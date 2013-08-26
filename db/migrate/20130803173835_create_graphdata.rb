class CreateGraphdata < ActiveRecord::Migration
  def change
    create_table :graphdata do |t|
   	  t.string :visits
   	  t.string :cupons_created
   	  t.string :cupons_redeemed
   	  t.string :cupons_shared
      t.string :top_influencers
      t.string :top_visitors
   	  t.datetime :recieved
      t.timestamps
    end
  end
end
