require 'spec_helper'

describe FreeRangeDefinition do

  before do
    @frd = Factory(:free_range_definition)
  end
  
  describe "validation" do
    
    it "validates" do
      @frd.should be_valid
    end
    
    it "validates presence of body" do
      @frd.body = nil
      @frd.should have(1).error_on(:body)
    end
    
    it "validates presence of page_url" do
      @frd.page_url = nil
      @frd.should have(1).error_on(:page_url)
    end

    it "validates presence of page_title" do
      @frd.page_title = nil
      @frd.should have(1).error_on(:page_title)
    end
  
  end

end
