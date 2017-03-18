class CreateRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :requests do |t|
      t.string :status, default: "opened"

      t.string :title
      
      t.integer :category_id
      t.index :category_id

      t.integer :user_id
      t.index :user_id

      t.integer :messages_count, default: 0
      t.integer :new_messages_count_for_customer, default: 0
      t.integer :new_messages_count_for_support, default: 0

      t.timestamps
    end
  end
end
