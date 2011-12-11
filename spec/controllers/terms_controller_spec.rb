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

    it "assigns @term" do
      get :disambiguations, :id => 'foo'
      assigns(:term).should be_a Term
    end
        
  end

  describe "GET translations" do

    it "assigns @term" do
      get :translations, :id => 'foo'
      assigns(:term).should be_a Term
    end
        
  end

  describe "GET free_range_definitions" do
    
    it "assigns @term" do
      get :free_range_definitions, :id => 'foo'
      assigns(:term).should be_a Term
    end
        
  end

  describe "GET wikipedia_definition" do

    it "assigns @term" do
      get :wikipedia_definition, :id => 'cat'
      assigns(:term).should be_a Term
    end
        
  end



end
