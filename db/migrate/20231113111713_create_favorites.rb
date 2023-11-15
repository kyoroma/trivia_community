class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
      t.integer :favorite_id, null: false
      t.integer :user_id, null: false
      t.integer :post_id, null: false
      t.timestamps

      t.index :favorite_id, unique: true
      t.index :user_id
      t.index :post_id
    end
  end
end
