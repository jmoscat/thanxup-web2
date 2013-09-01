class Venue < ActiveRecord::Base
  belongs_to :user
  attr_accessible :venue_thnx_id
end
