require 'spec_helper'

describe Term do
  
  before do
    @term = Factory(:term)
  end
  
  it "validates presence of name" do
    @term.should be_valid
    @term.name = nil
    @term.should_not be_valid
  end
  
  it "has disambiguations" do
    @term.disambiguations.size.should == 0
    @term.disambiguations.build(:name => 'Baseball bat')
    @term.disambiguations.build(:name => 'HMS Bat')
    @term.disambiguations.build(:name => 'Bat (animal)')
    @term.save!
    @term.disambiguations.size.should == 3
  end
  
  describe "wikified_name" do
    it "capitalizes its first letter" do
      @term.name = "fish"
      @term.wikified_name.should == "Fish"      
    end
    
    it "underscores spaces" do
      @term.name = "juan too tree"
      @term.wikified_name.should == "Juan_too_tree"
    end
  end
end
