class Venue
  include Mongoid::Document
  include Mongoid::Timestamps
  field :venue_thnx_id, type: String
  field :venue_name, type: String, :default => "Your venue"
  field :offer_on, type: Boolean, :default => false
  belongs_to :user
  attr_accessible :venue_thnx_id, :venue_name, :offer_on
end
