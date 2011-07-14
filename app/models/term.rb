class Term
  include MongoMapper::Document

   key :name, String, :required => true, :unique => true

   many :disambiguations
   many :translations
   many :free_range_definitions
   
   def process!
     disambiguate!
     translate!
     lasso!
   end

   def disambiguate!
     
    # Scrape the page
    page = Page.new(self.disambiguation_url)
    self.save! and return unless page.valid?
      
    # Build a *unique* array of links that contain the term
    links = page.parsed.css('#bodyContent a').map do |link|
      next unless link.content.downcase.include?(self.name.downcase)
      next if link.content.include?('disambiguation')
      next if link.content.include?('http')
      next if link.content.downcase == self.name.downcase
      link
    end.compact.uniq
    
    # Create dabs
    links.each do |link|
      self.disambiguations.build(:name => link.content)
    end
        
    self.save!
  end
  
  def translate!

    # Scrape the page
    page = Page.new(self.url)
    self.save! and return unless page.valid?
      
    # Iterate over tranlation elements, generating translation objects
    #
    # <li class="interwiki-es FA" title="This is a featured article in another language.">
    # <a href="http://es.wikipedia.org/wiki/Felis_silvestris_catus" title="Felis silvestris catus">Español</a></li>
    page.parsed.css('#p-lang li').each do |li|
      t = self.translations.build
      link = li.css('a').first
      t.name = link['title']
      t.language_code = link['href'].scan(/(\w+).wikipedia.org/).flatten.first
      t.language_name = link.content
    end
            
    self.save!
  end
  
  def lasso!
    
    # Scrape the page
    # page = Page.new(self.fred_url)
    # self.save! and return unless page.valid?

    # Iterate over google search results elements, generating FRD objects
    #
    # <div class="vsc" sig="Tz3" rawurl="http://www.cheeseisalive.com/">
    #   <div class="vspi"></div>
    #   <h3 class="r">
    #     <span class="tl"><a href="http://www.cheeseisalive.com/" class="l" onmousedown="return clk(this.href,'','','','2','ByppgxfX6Xx2-jpWfk1MBQ','0CCsQFjAB')"><em>Cheese Is</em> Alive</a></span>
    #   </h3><span class="tl"><button class="esw eswd eswh" onclick="window.gbar&amp;&amp;gbar.pw&amp;&amp;gbar.pw.clk(this)" onmouseover="window.gbar&amp;&amp;gbar.pw&amp;&amp;gbar.pw.hvr(this,google.time())" g:entity="http://www.cheeseisalive.com/" g:type="plusone" g:undo="poS1" title="Recommend this page" g:pingback="/gen_204?atyp=i&amp;ct=plusone&amp;cad=S1" id="gbpwm_1" style=""></button></span>
    #   <div class="s">
    #     <div class="f kv">
    #       <cite>www.<b>cheeseis</b>alive.com/</cite> <span class="gl">- <a href="http://webcache.googleusercontent.com/search?q=cache:AvUS1Xv2XV0J:www.cheeseisalive.com/+%22cheese+is%22&amp;cd=2&amp;hl=en&amp;ct=clnk&amp;gl=us&amp;source=www.google.com" onmousedown="return clk('http://webcache.googleusercontent.com/search?q=cache:AvUS1Xv2XV0J:www.cheeseisalive.com/+%22cheese+is%22&amp;cd=2&amp;hl=en&amp;ct=clnk&amp;gl=us&amp;source=www.google.com','','','','2','iAnDZQjbo3VYbEv_Mfz9RQ','0CDEQIDAB')">Cached</a></span><span class="vshid"><a href="/search?hl=en&amp;q=related:www.cheeseisalive.com/+%22cheese+is%22&amp;tbo=1&amp;sa=X&amp;ei=HokeTsLhHYjTiALyo7zJAw&amp;ved=0CDIQHzAB">Similar</a></span>
    #     </div>
    #     <div class="esc kb" id="poS1" style="display:none">
    #       You +1'd this publicly.&nbsp;<a href="#">Undo</a>
    #     </div><span class="st"><em>Cheese is</em> sexy, stinky, soft, hard, firm, smoked, blue, washed, bloomy, acidic, grassy, herbaceous, milky, sweet, savory, aged, fresh and delicious. <b>...</b><br></span>
    #   </div>
    # </div>


    agent = Mechanize.new do |agent|
      agent.user_agent_alias = "Mac Safari"
    end

    agent.get('http://google.com/') do |page|
      search_result = page.form_with(:name => 'f') do |search|
        search.q = "\"#{self.name} is\""
      end.submit

      # raise search_result.search('div.vsc').inspect
      # raise search_result.inspect
      
      search_result.search('li.g').each do |result|
        # raise result.inspect
        # Rails.logger.debug "\n\n#{result.search('span')}\n\n"
        
        raise result.search('body').content.inspect
        
        # frd = self.free_range_definitions.build
        # frd.body = result.search('span.st').first.content
        # frd.page_url = result.search('a.l').first['href']
        # frd.page_title = result.search('a.l').first.content
      end

    end
    
    # raise page.raw.inspect
    # raise page.parsed.inspect
    
    # page.links.each do |link|
    #   Rails.logger.debug link.inspect
    # end
    
    # page.css('div.vsc').each do |result|
    #   frd = self.free_range_definitions.build
    #   frd.body = result.css('span.st').first.content
    #   frd.page_url = result.css('a.l').first['href']
    #   frd.page_title = result.css('a.l').first.content
    # end
    #         
    # self.save!
  end
  
  def url
    "http://en.wikipedia.org/wiki/#{self.wikified_name}"
  end  
  
  def disambiguation_url
    "http://en.wikipedia.org/wiki/#{self.wikified_name}_(disambiguation)"
  end

  def fred_url
    "http://www.google.com/search?hl=en&q=%22#{self.name}+is%22"
  end

  # Capitalize first letter and replace spaces with underscores
  def wikified_name
     self.name.slice(0,1).capitalize + self.name.slice(1..-1).gsub(/ /, '_')
  end
   
end
