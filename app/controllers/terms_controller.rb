class TermsController < ApplicationController
  
  def show
    @term = Term.find_or_initialize_by_name(params[:id])
    
    Rails.logger.debug @term.disambiguation_url.red_on_yellow
    
    @term.disambiguate! if @term.new_record?

    respond_to do |format|
      format.html
      format.json { render :json => @term.disambiguations.map(&:name).to_json }
    end
  end
  
end
