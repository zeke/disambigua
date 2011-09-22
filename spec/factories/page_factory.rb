Factory.define :page, :default_strategy => :stub do |page|
  page.url 'http://en.wikipedia.org/wiki/Cat'
  page.raw 'scraped HTML goes here'
  page.parsed 'parse of raw HTML goes here'
end

Factory.define :google_page, :class => :page, :default_strategy => :stub do |page|
  page.url 'http://www.google.com/search?q=dog'
  page.raw 'scraped google HTML goes here'
  page.parsed 'parse of raw HTML goes here'
end