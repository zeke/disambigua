require 'spec_helper'

describe Page do
  
  before do
    @page = Factory(:page)
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
  
  describe "scrape_technique" do
    
    it "is simple if URL is on google.com" do
      @page = Factory(:google_page)
      @page.scrape_technique.should == 'simple'
    end
    
    it "is advanced if URL is not on google.com" do
      @page.scrape_technique.should_not include('google.com')
      @page.scrape_technique.should == 'advanced'
    end
    
  end
  
end
