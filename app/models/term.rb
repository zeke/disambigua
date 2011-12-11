# require 'open-uri'

class Term
  include MongoMapper::Document

   key :name, String, :required => true, :unique => true

   many :disambiguations
   many :translations
   many :free_range_definitions
   one :wikipedia_definition
   
   def process!
     disambiguate!
     translate!
     lasso!
   end

   def disambiguate!
     return true if disambiguations.present?
     
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
    return true if translations.present?

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
      t.name = URI.unescape(link[:href].split("/").last).gsub('_', ' ')
      t.language_code = link['href'].scan(/(\w+).wikipedia.org/).flatten.first
      t.language_name = link.content
    end
            
    self.save!
  end
  
  def lasso!
    page = Page.new(fred_url)
    
    page.parsed.css('li.g').each do |result|      
      frd = self.free_range_definitions.build
      frd.page_title = result.css('h3.r a').first.inner_html.strip_tags
      frd.page_url = result.css('h3.r a').first[:href]
      frd.body = result.css('div.s').inner_html.encode("UTF-8")
    end
    
    self.save!
  end
  
  def get_wikipedia_definition!
    return true if wikipedia_definition.present?

    # Scrape the page
    begin
      page = Page.new(self.url)
      self.save! and return unless page.valid?
    rescue
      return
    end

    # Grab the first paragraph from the bodyContent
    self.wikipedia_definition = WikipediaDefinition.new(
      :text => page.parsed.css('#bodyContent p:first').inner_html
    )
            
    self.save!
  end
  
  def url
    "http://en.wikipedia.org/wiki/#{self.wikified_name}"
  end  
  
  def disambiguation_url
    "http://en.wikipedia.org/wiki/#{self.wikified_name}_(disambiguation)"
  end

  def fred_url
    URI.encode "http://www.google.com/search?hl=en&q=\"#{self.name}+is\""
  end

  # Capitalize first letter and replace spaces with underscores
  def wikified_name
     self.name.slice(0,1).capitalize + self.name.slice(1..-1).gsub(/ /, '_')
  end
   
end
