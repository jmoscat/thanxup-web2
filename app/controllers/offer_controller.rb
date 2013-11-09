class OfferController < ApplicationController
  def index
  	@venues = current_user.venues
  end
  def myoffers
    @venue = Venue.find_by(venue_thnx_id: params[:id])
    
  end
end
