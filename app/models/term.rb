class Term
  include MongoMapper::Document

   key :name, String, :required => true, :unique => true

   many :disambiguations
   many :translations
   
   def process!
     disambiguate!
     translate!
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
  
  def url
    "http://en.wikipedia.org/wiki/#{self.wikified_name}"
  end  
  
  def disambiguation_url
    "http://en.wikipedia.org/wiki/#{self.wikified_name}_(disambiguation)"
  end

  # Capitalize first letter and replace spaces with underscores
  def wikified_name
     self.name.slice(0,1).capitalize + self.name.slice(1..-1).gsub(/ /, '_')
  end
   
end
