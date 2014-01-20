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
  	if JSON.parse(@respond)["status"] == "1"
  		venue = Venue.find_by(venue_thnx_id: params[:venue_id])
  		venue.offer_on = true
  		venue.save
    	flash[:notice] = "Oferta guardada ;)"
		 url = "/offer/"+params[:venue_id] +"/myoffers"
		 redirect_to url
    else
        flash[:error] = "Ha habido un error al guardar la oferta, por favor vuelve a intentarlo"
        url = "/offer/"+params[:venue_id] +"/edit"
        redirect_to url
    end
  end

  def delete
  	respond = Offer.delete_offer(params[:id])
  	if respond["status"] == "1"
  		venue = Venue.find_by(venue_thnx_id: params[:id])
  		venue.offer_on = false
  		venue.save
  		flash[:notice] = "Oferta borrada"
  		redirect_to "/offer"
  	else
  		flash[:error] = "Ha habido un error al borrar la oferta, vuelve a intentarlo"
  		redirect_to "/offer"
  	end
  end


end