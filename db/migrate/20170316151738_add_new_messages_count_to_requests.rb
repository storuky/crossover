class AddNewMessagesCountToRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :requests, :new_messages_count_for_sender, :integer, default: 0
    add_column :requests, :new_messages_count_for_support, :integer, default: 0
  end
end
