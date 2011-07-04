class TermsController < ApplicationController
  
  def index
    @terms = Term.all
    respond_to do |format|
      # format.html
      format.json { render :json => @terms }
    end
  end
  
  def show
    @term = Term.find_or_initialize_by_name(params[:id])
    
    @term.process! if @term.new_record?

    respond_to do |format|
      # format.html
      format.json { render :json => @term }
    end
  end
  
end
