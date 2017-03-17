class AddDeltaToUsersAndRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :delta, :boolean, default: true
    add_column :requests, :delta, :boolean, default: true
  end
end
