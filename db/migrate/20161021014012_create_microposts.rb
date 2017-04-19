class CreateMicroposts < ActiveRecord::Migration[5.0]
  def change
    create_table :microposts do |t|
      t.integer :user_id, index: true
      t.integer :bus_stop_id, index: true
      t.text :content
      t.timestamps null: false
    end
    add_index :microposts, [:user_id, :bus_stop_id, :created_at]
  end
end
