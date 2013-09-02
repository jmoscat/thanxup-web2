class Venue
  include Mongoid::Document
  include Mongoid::Timestamps
  field :venue_thnx_id, type: String
  belongs_to :user
  attr_accessible :venue_thnx_id
end
