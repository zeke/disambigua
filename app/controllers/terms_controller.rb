class TermsController < ApplicationController
  
  def index
    @terms = Term.all
    respond_to do |format|
      # format.html
      format.json { render :json => @terms }
    end
  end
  
  # def show
  #   @term = Term.find_or_initialize_by_name(params[:id])
  #   @term.process! if @term.new_record?
  # 
  #   respond_to do |format|
  #     format.json { render :json => @term, :except => [:id] }
  #   end
  # end

  def disambiguations
    @term = Term.find_or_initialize_by_name(params[:id])
    @term.process! if @term.new_record?

    respond_to do |format|
      format.json { render :json => @term.disambiguations, :except => [:id] }
    end
  end

  def translations
    @term = Term.find_or_initialize_by_name(params[:id])
    @term.process! if @term.new_record?

    respond_to do |format|
      format.json { render :json => @term.translations, :except => [:id] }
    end
  end

  
end
