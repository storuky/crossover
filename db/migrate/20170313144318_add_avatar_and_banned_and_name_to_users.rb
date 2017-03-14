class AddAvatarAndBannedAndNameToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :avatar_id, :integer
    add_index :users, :avatar_id

    add_column :users, :name, :string
    add_column :users, :banned, :boolean
  end
end
