class Database
  include Mongoid::Document
  include Mongoid::Timestamps
  field :db_id, type: Integer #1 for api always, 2 for coupon
  field :source, type: String
  field :server, type: String
  field :port, type: Integer
  field :db_name, type: String
  field :user, type: String
  field :password, type: String
end
