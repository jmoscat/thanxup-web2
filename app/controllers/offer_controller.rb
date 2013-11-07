class OfferController < ApplicationController

  def index
  	@venues = current_user.venues
  end
  def update_offer
    @offer = User.find_by(venue_id: params[:venue_id])
    @user.update_attributes(params[:user])
    respond_to do |format|
        format.html { redirect_to admin_path }
        format.json { respond_with_bip(@user) }
    end
  end
end
