class Page
  require 'active_model'
  include ActiveModel::Validations

  attr_accessor :url, :raw, :parsed  
  
  validates_presence_of :raw, :parsed
    
  def initialize(url)

    self.url = url

    # Spoof user agent to avoid a 403 unauthorized
    agent = Mechanize.new do |agent|
      agent.user_agent_alias = "Linux Mozilla"
    end

    # Get the page and parse it.
    self.raw = agent.get(url)
    self.parsed = Nokogiri::HTML.parse(self.raw.body, nil, "UTF-8")

    self
  end
   
end
