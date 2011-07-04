require 'spec_helper'

describe Page do
  
  before do
    @page = Page.new('http://en.wikipedia.org/wiki/Dog')
    @page.raw = 'HTML'
    @page.parsed = 'nokogiri parsed HTML'
  end
    
  describe "validations" do
    
    it "validates" do
      @page.should be_valid
    end
  
    it "validates presence of raw" do
      @page.raw = nil
      @page.should have(1).error_on(:raw)
    end
    
    it "validates presence of parsed" do
      @page.parsed = nil
      @page.should have(1).error_on(:parsed)
    end
  
  end
  
end
