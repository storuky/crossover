class CreateRequestMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :request_messages do |t|
      t.text :content

      t.integer :request_id
      t.index :request_id

      t.integer :user_id
      t.index :user_id

      t.timestamps
    end
  end
end
