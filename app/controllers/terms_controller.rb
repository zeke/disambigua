class TermsController < ApplicationController
  
  before_filter :find_term, :only => [:disambiguations, :translations, :free_range_definitions]
  
  def index
    @terms = Term.all
    respond_to do |format|
      # format.html
      format.json { render :json => @terms }
    end
  end

  def disambiguations
    @term.disambiguate unless @term.disambiguations.present?

    respond_to do |format|
      format.json { render :json => @term.disambiguations, :except => [:id] }
    end
  end

  def translations
    @term.translate! unless @term.translations.present?

    respond_to do |format|
      format.json { render :json => @term.translations, :except => [:id] }
    end
  end
  
  def free_range_definitions
    @term.lasso!# unless @term.free_range_definitions.present?

    respond_to do |format|
      format.json { render :json => @term.free_range_definitions, :except => [:id] }
    end
  end

protected

  def find_term
    @term = Term.find_or_initialize_by_name(params[:id])
  end

end
