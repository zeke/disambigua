require 'open-uri'

class Page
  require 'active_model'
  include ActiveModel::Validations

  attr_accessor :id, :url, :raw, :parsed
  
  validates_presence_of :raw, :parsed
    
  def initialize(url=nil)
    self.url = url
    fetch unless url.blank?
  end
  
  def fetch
    if scrape_technique == 'simple'
      self.parsed = self.raw = Nokogiri::HTML(open(self.url))
    else
      # Spoof user agent to avoid a 403 unauthorized
      agent = Mechanize.new do |agent|
        agent.user_agent_alias = "Linux Mozilla"
      end

      # Get the page and parse it.
      self.raw = agent.get(url)
      self.parsed = Nokogiri::HTML.parse(self.raw.body, nil, "UTF-8")  
    end

    self
  end
  
  def scrape_technique
    url =~ /google\.com/ ? 'simple' : 'advanced'
  end
   
end
