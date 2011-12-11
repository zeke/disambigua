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

  describe "GET disambiguations" do
    
    before do
      @term = Factory(:term, :name => 'foo')
    end
    
    it "assigns @term" do
      # Term.should_receive(:find_or_initialize_by_name).with('foo').and_return(@term)
      get :disambiguations, :id => 'foo'
      assigns(:term).should be_a Term
    end
        
  end

  describe "GET free_range_definitions" do
    
    before do
      @term = Factory(:term, :name => 'foo')
    end
    
    it "assigns @term" do
      Term.should_receive(:find_or_initialize_by_name).with('foo').and_return(@term)
      get :free_range_definitions, :id => 'foo'
      assigns(:term).should eq(@term)
    end
        
  end


end
