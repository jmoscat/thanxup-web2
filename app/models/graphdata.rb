include Mongo
class Graphdata < ActiveRecord::Base
  belongs_to :user
  
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

  def self.createCupons(db_handle, store_id)
  	time = Time.now.utc - 1.month
  	cupons_created = Graphdata.hash
	rest = db_handle.collection("cupons").find({store_id: store_id,created_at: {"$gte" => time}},:fields => ["created_at"])
	rest.to_a.each do |s|
	  cupons_created[s["created_at"].strftime("%Y-%m-%d")] += 1
	end

	out = "["
	cupons_created.keys.each do |x|
	  out =  out + "{Dia: " + x + ", Nuevos Cupones: " + cupons_created[x].to_s + "}"
	  if (x!=cupons_created.keys.last)
	    out = out + ","
	  end
	end
	out = out + "]"
	return out
  end

  def self.redeemedCupons(db_handle, store_id)
  	cupons_redeemed = Graphdata.hash
  	time = Time.now.utc - 1.month
  	rest = db_handle.collection("cupons").find({store_id: store_id,used_date: {"$gte" => time}},:fields => ["used_date"])
  	rest.to_a.each do |s|
		cupons_redeemed[s["used_date"].strftime("%Y-%m-%d")] += 1
	end
	out = "["
	cupons_redeemed.keys.each do |x|
	  out =  out + "{Dia: " + x + ", Cupones Usados: " + cupons_redeemed[x].to_s + "}"
	  if (x!=cupons_redeemed.keys.last)
	    out = out + ","
	  end
	end
	out = out + "]"
	return out

  end

  def self.sharedCupons(db_handle, store_id)
  	cupons_shared = GraphData.hash
  	time = Time.now.utc - 1.month
  	rest = db_handle.collection("cupons").find({store_id: store_id,shared_date: {"$gte" => time}},:fields => ["shared_date"])
  	rest.to_a.each do |s|
	  cupons_shared[s["shared_date"].strftime("%Y-%m-%d")] += 2
	end
	out = "["
	cupons_shared.keys.each do |x|
	  out =  out + "{Dia: " + x + ", Cupones Compartidos: " + cupons_shared[x].to_s + "}"
	  if (x!=cupons_shared.keys.last)
	    out = out + ","
	  end
	end
	out = out + "]"
	return out

  end

  def self.visits(db_handle, store_id)
  	all_visits = Graphdata.hash
  	recurrent_visits = Graphdata.hash
  	time = Time.now.utc - 1.month
  	rest = db_handle.collection("venue-visits").find({venue_id: store_id,created_at: {"$gte" => time}},:fields => ["created_at"])
  	rest.to_a.each do |s|
	  all_visits[s["created_at"].strftime("%Y-%m-%d")] += 1
	end

	rest = db_handle.collection("venue-visits").find({venue_id: store_id,visit_count: {"$gte" => 0},created_at: {"$gte" => time}},:fields => ["created_at"])
	rest.to_a.each do |s|
	  recurrent_visits[s["created_at"].strftime("%Y-%m-%d")] += 1
	end

	out = "["
	all_visits.keys.each do |x|
	  out =  out + "{Dia: '" + x + "', Total Visitas: " + all_visits[x].to_s + ", Visitas Recurrentes: " + recurrent_visits[x].to_s+ "}"
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
  end
end
