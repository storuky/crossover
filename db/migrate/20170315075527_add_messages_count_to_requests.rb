class AddMessagesCountToRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :requests, :messages_count, :integer, default: 0
  end
end
