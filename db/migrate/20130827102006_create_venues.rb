class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :venue_thnx_id, :null => false, :default => ""
      t.string :user_id, :null => false
      t.timestamps
    end
  end
end
