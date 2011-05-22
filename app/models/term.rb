class Term
  include MongoMapper::Document

   key :name, String, :required => true, :unique => true
   # key :age,  Integer

   many :disambiguations

   def disambiguate!     

    # Spoof user agent to avoid a 403 unauthorized
    agent = Mechanize.new do |agent|
      agent.user_agent_alias = "Linux Mozilla"
    end

    # Get the page and parse it
    body = agent.get(self.disambiguation_url).body
    doc = Nokogiri::HTML.parse(body, nil, "UTF-8")
    
    # build a unique array of links that contain the term
    links = doc.css('#bodyContent a').map do |link|
      next unless link.content.downcase.include?(self.name.downcase)
      next if link.content.include?('disambiguation')
      next if link.content.include?('http')
      next if link.content.downcase == self.name.downcase
      link
    end.compact.uniq
    
    # create dabs
    links.each do |link|
      self.disambiguations.build(:name => link.content)
    end
        
    self.save!
  end
  
  def disambiguation_url
    "http://en.wikipedia.org/wiki/#{self.wikified_name}_(disambiguation)"
  end

   def wikified_name
     wn = self.name.slice(0,1).capitalize + self.name.slice(1..-1) # capitalize first letter
     wn.gsub(/ /, '_') # replace spaces with underscores
  end
   
end
