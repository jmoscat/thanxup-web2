class CreateGraphdata < ActiveRecord::Migration
  def change
    create_table :graphdata do |t|
   	  t.string :visit
   	  t.string :cupon
   	  t.string :top_user
   	  t.string :reach
   	  t.datetime :recieved
      t.timestamps
    end
  end
end
