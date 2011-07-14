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
  
  describe "process!" do
    
    it "disambiguates and translates when process! is called" do
      @term.should_receive(:disambiguate!).and_return(true)
      @term.should_receive(:translate!).and_return(true)
      @term.should_receive(:lasso!).and_return(true)
      @term.process!
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
  
  describe "translation" do
  
    it "has associated translations" do
      @term = Term.create!(:name => 'cat')
      @term.translations.size.should == 0
      @term.translations.build(:name => 'gato')
      @term.translations.build(:name => 'chat')
      @term.translations.build(:name => 'felini')
      @term.save!
      @term.translations.size.should == 3
    end
  
    it "auto-translates" do
      @term = Term.create!(:name => 'cat')
      @term.translate!
      @term.translations.should_not be_empty
      raw_translations = @term.translations.map(&:name)
      raw_translations.should include('Chat')
      raw_translations.should include('Felis silvestris catus')
    end
    
  end
  
  describe "free range definitions" do
  
    it "has associated FRDs" do
      @term = Term.create!(:name => 'cheese')
      @term.free_range_definitions.size.should == 0
      @term.free_range_definitions.build(:body => 'cheese is great', :page_url => "http://cheese.com", :page_title => 'Cheese!')
      @term.free_range_definitions.build(:body => 'cheese is grate', :page_url => "http://cheese.com", :page_title => 'Cheese!')
      @term.free_range_definitions.build(:body => 'cheese is my friend', :page_url => "http://cheese.com", :page_title => 'Cheese!')
      @term.save!
      @term.free_range_definitions.size.should == 3
    end
  
    it "auto-lassos" do
      @term = Term.create!(:name => 'cheese')
      @term.lasso!
      @term.free_range_definitions.should_not be_empty
      raw_freds = @term.translations.map(&:page_url)
      raw_freds.should include('http://www.cheese.com/')
    end
    
  end
  
  describe "URLs" do
    
    before do
      @term.name = "cheese whiz"
    end
    
    it "has a URL" do
      @term.url.should =~ /wiki\/Cheese_whiz/
    end
    
    it "has a disambiguation URL" do
      @term.disambiguation_url.should =~ /wiki\/Cheese_whiz_\(disambiguation\)/
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
