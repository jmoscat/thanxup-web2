class StatusController < ApplicationController
  before_filter :authenticate_user!
  def index
    if current_user.role_access?(User.manager_role)
      @venues = Venue.all
    else
      @venues = current_user.venues
    end
  end

  def stat
  	id = params[:id]
  	@name = Stat.where(venue_id: id).last.name
  	@cupons_created = Stat.where(venue_id: id).last.cupon_created
  	@cupons_used = Stat.where(venue_id: id).last.cupon_used
  	@visits = Stat.where(venue_id: id).last.visits
  	@cupons_shared= Stat.where(venue_id: id).last.cupon_shared
  end
end
