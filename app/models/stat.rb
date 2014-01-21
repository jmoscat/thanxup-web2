include Mongo
class Stat
  include Mongoid::Document
  include Mongoid::Timestamps

  field :venue_id, type: String
  field :visits, type: String
  field :cupon_used, type: String
  field :cupon_shared, type: String
  field :cupon_created, type: String
  field :influencers, type: String
  field :name, type: String
  field :loyals, type: String
  index({venue_id: 1},{unique: true, background: true})


#"%Y-%m-%d"
  def self.create_connection(server, port,db,user,passw)
  	db = MongoClient.new(server,port).db(db)
  	auth = db.authenticate(user, passw)
  	return db
  end

  def self.hash
  	hash_prepared = Hash.new(0)
	((Date.today - 30.days)..Date.today).each do |s|
  	  hash_prepared[s.strftime("%Y-%m-%d")] = 0
	end
  	return hash_prepared
  end

  def self.createdCupons(db_handle, store_id)
  	time = Time.now.utc - 1.month
  	cupons_created = Stat.hash
	rest = db_handle.collection("cupons").find({store_id: store_id,created_at: {"$gte" => time}},:fields => ["created_at"])
	rest.to_a.each do |s|
	  cupons_created[s["created_at"].strftime("%Y-%m-%d")] += 1
	end

	out = "["
	cupons_created.keys.each do |x|
	  out =  out + "{x: '" + x + "', y: " + cupons_created[x].to_s + "}"
	  if (x!=cupons_created.keys.last)
	    out = out + ","
	  end
	end
	out = out + "]"
	return out
  end

  def self.redeemedCupons(db_handle, store_id)
  	cupons_redeemed = Stat.hash
  	time = Time.now.utc - 1.month
  	rest = db_handle.collection("cupons").find({store_id: store_id,used_date: {"$gte" => time}},:fields => ["used_date"])
  	rest.to_a.each do |s|
		  cupons_redeemed[s["used_date"].strftime("%Y-%m-%d")] += 1
  	end
  	out = "["
  	cupons_redeemed.keys.each do |x|
  	  out =  out + "{x: '" + x + "', y: " + cupons_redeemed[x].to_s + "}"
  	  if (x!=cupons_redeemed.keys.last)
  	    out = out + ","
  	  end
  	end
  	out = out + "]"
  	return out

  end

  def self.sharedCupons(db_handle, store_id)
  	cupons_shared = Stat.hash
  	time = Time.now.utc - 1.month
  	rest = db_handle.collection("cupons").find({store_id: store_id,shared_date: {"$gte" => time}},:fields => ["shared_date"])
  	rest.to_a.each do |s|
	    cupons_shared[s["shared_date"].strftime("%Y-%m-%d")] += 2
	  end
  	out = "["
  	cupons_shared.keys.each do |x|
  	  out =  out + "{x: '" + x + "', y: " + cupons_shared[x].to_s + "}"
  	  if (x!=cupons_shared.keys.last)
  	    out = out + ","
  	  end
  	end
  	out = out + "]"
  	return out

  end

  def self.visits(db_handle, store_id)
    	all_visits = Stat.hash
    	recurrent_visits = Stat.hash
    	time = Time.now.utc - 1.month
    	rest = db_handle.collection("venue_visits").find({venue_raw_id: store_id, created_at: {"$gte" => time}},:fields => ["created_at"])
    	rest.to_a.each do |s|
        all_visits[s["created_at"].strftime("%Y-%m-%d")] += 1
  	  end

  	rest = db_handle.collection("venue_visits").find({venue_raw_id: store_id, visit_count: {"$gte" => 0},created_at: {"$gte" => time}},:fields => ["created_at"])
  	rest.to_a.each do |s|
  	  recurrent_visits[s["created_at"].strftime("%Y-%m-%d")] += 1
  	end

  	out = "["
  	all_visits.keys.each do |x|
  	  out =  out + "{x: '" + x + "', y: " + all_visits[x].to_s + ", z: " + recurrent_visits[x].to_s+ "}"
  	  if (x!=all_visits.keys.last)
  	    out = out + ","
  	  end
  	end
  	out = out + "]"
	return out

  end

  def self.influencers

  end

  def self.recurrents
  end

  def self.daily
    new_logger = Logger.new('log/daily.log')
    new_logger.info("DAILY RUTINE- "+ Time.now.to_s+ " ")
    db_api_data = Database.find_by(db_id: 1)
    db_coupon_data = Database.find_by(db_id: 2)
  	db_cupon = Stat.create_connection(db_coupon_data.server, db_coupon_data.port, db_coupon_data.db_name, db_coupon_data.user,db_coupon_data.password)
  	db_api = Stat.create_connection(db_api_data.server, db_api_data.port, db_api_data.db_name, db_api_data.user, db_api_data.password)
  	Venue.each do |x|
      begin
    	  stat=Stat.where(venue_id: x.venue_thnx_id)
    	  if (stat.count(true) == 2)
    	  	stat.first.delete
    	  end

        rest = db_api.collection("venues").find({venue_id: x.venue_thnx_id},:fields => ["name"])
        venue_name = rest.to_a[0]["name"]
        if (stat.count(true) == 0)
          x.venue_name = venue_name
          x.save
        end
    	  stat_new = Stat.new
    	  stat_new.venue_id = x.venue_thnx_id
        stat_new.name = venue_name
    	  stat_new.visits = Stat.visits(db_api,x.venue_thnx_id)
    	  stat_new.cupon_used = Stat.redeemedCupons(db_cupon, x.venue_thnx_id)
    	  stat_new.cupon_shared = Stat.sharedCupons(db_cupon, x.venue_thnx_id)
    	  stat_new.cupon_created = Stat.createdCupons(db_cupon, x.venue_thnx_id)
    	  stat_new.save
        new_logger.info("\t SUCCESS: "+x.venue_thnx_id)
      rescue => e
        new_logger.info("\t FAILED: "+x.venue_thnx_id)
      end

  	end
  end
end
