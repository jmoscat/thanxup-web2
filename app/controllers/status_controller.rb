class StatusController < ApplicationController
  before_filter :authenticate_user!
  def index
  	@cupons_created = Stat.first.cupon_created
  	@cupons_used = Stat.first.cupon_used
  end
end
