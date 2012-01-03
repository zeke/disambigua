class TermsController < ApplicationController
  
  before_filter :find_term, :only => [:disambiguations, :translations, :free_range_definitions, :wikipedia_definition]
  
  def index
    @terms = Term.all
    respond_to do |format|
      # format.html
      format.json { render :json => @terms }
    end
  end

  def disambiguations
    @term.disambiguate!

    respond_to do |format|
      format.json { render :json => @term.disambiguations, :except => [:id], :callback => params[:callback] }
    end
  end

  def translations
    @term.translate!

    respond_to do |format|
      format.json { render :json => @term.translations, :except => [:id], :callback => params[:callback] }
    end
  end
  
  def free_range_definitions
    @term.lasso!# unless @term.free_range_definitions.present?

    respond_to do |format|
      format.json { render :json => @term.free_range_definitions, :except => [:id], :callback => params[:callback] }
    end
  end
  
  def wikipedia_definition
    @term.get_wikipedia_definition!

    respond_to do |format|
      format.json { render :json => @term.wikipedia_definition, :callback => params[:callback] }
    end
  end


protected

  def find_term
    @term = Term.find_or_initialize_by_name(params[:id])
  end

end
