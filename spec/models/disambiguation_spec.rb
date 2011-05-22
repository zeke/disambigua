require 'spec_helper'

describe Disambiguation do

  before do
    @dab = Factory(:disambiguation)
  end
  
  it "validates presence of name" do
    @dab.should be_valid
    @dab.name = nil
    @dab.should_not be_valid
  end

end
