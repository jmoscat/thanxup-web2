class AddUsernameToUsers < ActiveRecord::Migration
  def change
   # username is a required, unique field
    add_column :users, :username, :string, :null => false, :default => "" 
    add_index  :users, :username, :unique => true
  end
end
