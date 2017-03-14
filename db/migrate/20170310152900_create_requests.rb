class CreateRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :requests do |t|
      t.string :status, default: "opened"

      t.string :title
      
      t.integer :category_id
      t.index :category_id

      t.integer :user_id
      t.index :user_id

      t.timestamps
    end
  end
end
