class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :micropost_id
      t.text :body,null: false
      t.references :user, index: true

      t.timestamps null: false
    end
    add_index :comments, :micropost_id
  end
end
