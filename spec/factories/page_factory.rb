Factory.define :page, :default_strategy => :stub do |page|
  page.url 'http://en.wikipedia.org/wiki/Cat'
  page.raw 'scraped HTML goes here'
  page.parsed 'nokogiri parse of raw goes here'
end