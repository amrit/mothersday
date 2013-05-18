class AddAccessTokenToUser < ActiveRecord::Migration
  def change
  	add_column :users, :access_token, :boolean
  end
end
