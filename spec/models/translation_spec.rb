require 'spec_helper'

describe Translation do

  before do
    @t = Factory(:translation)
  end
  
  describe "validation" do
    
    it "validates" do
      @t.should be_valid
    end
    
    it "validates presence of name" do
      @t.name = nil
      @t.should have(1).error_on(:name)
    end
    
    it "validates presence of language code" do
      @t.language_code = nil
      @t.should have(1).error_on(:language_code)
    end

    it "validates presence of language name" do
      @t.language_name = nil
      @t.should have(1).error_on(:language_name)
    end
  
  end

end
