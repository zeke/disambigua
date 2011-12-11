require 'spec_helper'

describe WikipediaDefinition do

  before do
    @wd = Factory(:wikipedia_definition)
  end
  
  it "validates presence of text" do
    @wd.should be_valid
    @wd.text = nil
    @wd.should_not be_valid
  end

  describe "clean_text" do
    
    it "strips HTML" do
      @wd.text = "Canis lupus is a <b>bold</b> character."
      @wd.clean_text.should =~ /is a bold character/
    end
    
    it "removes footnotes" do
      @wd.text = "Canis lupus dingo[1][2] is a domesticated form of the gray wolf."
      @wd.clean_text.should =~ /lupus dingo is/
    end
    
  end

end
