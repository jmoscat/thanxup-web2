class OfferController < ApplicationController
  before_filter :authenticate_user!
  
  def index
  	@venues = current_user.venues
  end

  def myoffers
    @venue = Venue.find_by(venue_thnx_id: params[:id])
  	@respond = Offer.getoffer(params[:id])
  end

  def edit
  	@venue_id = params[:id]
  	#Venue has offer set flag
  end

  def setoffer
  	@respond = Offer.setoffer(params)
  	if @respond == "1"
  		venue = Venue.find_by(venue_thnx_id: params[:venue_id])
  		venue.offer_on = true
  		venue.save
    	flash[:notice] = t(:Oferta_guardada)
    else
        flash[:error] = t(:ha_habido_un_error_al_guardar_oferta)
    end
  	redirect_to offer_path
  end
end