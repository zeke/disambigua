require 'spec_helper'

describe TermsController do
  
  describe "GET index" do
    
    before do
      @terms = [Factory(:term)]
    end
    
    it "assigns all terms as @terms" do
      Term.should_receive(:all).and_return(@terms)
      get :index
      assigns(:terms).should eq(@terms)
    end
    
  end

  describe "GET show" do
    
    before do
      @term = Factory(:term, :name => 'foo')
    end
    
    it "assigns @term" do
      Term.should_receive(:find_or_initialize_by_name).with('foo').and_return(@term)
      get :show, :id => 'foo'
      assigns(:term).should eq(@term)
    end
    
    # it "honors `disambigation_only` param"

    # it "honors `translation_only` param"
    
  end

end
