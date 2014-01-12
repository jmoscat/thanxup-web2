require 'rest_client'
class Offer
  include Mongoid::Document

  def self.getoffer(venue_id)
  	url = "http://localhost:3000/back/getoffer"
  	respond =  RestClient.post url, {:venue_id => venue_id}.to_json, :content_type => :json, :accept => :json
  	return  respond
  end

  def self.setoffer (params)
  	url = "http://localhost:3000/back/setoffer"
  	debugger
  	respond =  RestClient.post url, params.to_json, :content_type => :json, :accept => :json
  	return  respond
  end
end
