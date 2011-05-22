require 'spec_helper'

describe Term do
  
  before(:each) do
    @term = Factory(:term)
  end
  
  after(:each) do
    Term.destroy_all
  end
  
  describe "validations" do
  
    it "validates presence of name" do
      @term.should be_valid
      @term.name = nil
      @term.should_not be_valid
    end
    
    it "validates uniqueness of name" do
      @term1 = Term.create!(:name => 'bat')
      Term.count.should == 1
      @term2 = Term.new(:name => 'bat')
      @term2.should_not be_valid
    end
  
  end
  
  describe "disambiguation" do
  
    it "has associated dabs" do
      @term = Term.create!(:name => 'bat')
      @term.disambiguations.size.should == 0
      @term.disambiguations.build(:name => 'Baseball bat')
      @term.disambiguations.build(:name => 'HMS Bat')
      @term.disambiguations.build(:name => 'Bat (animal)')
      @term.save!
      @term.disambiguations.size.should == 3
    end
  
    it "auto-disambiguates" do
      @term = Term.create!(:name => 'bat')
      @term.disambiguate!
      @term.disambiguations.should_not be_empty
      raw_dabs = @term.disambiguations.map(&:name)
      raw_dabs.should include('The Bat (1926 film)')
      raw_dabs.should include('Bat (goddess)')
    end
    
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
