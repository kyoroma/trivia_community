class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :post_id, null: false
      t.text :posted_article, null: false
      t.string :tag_list, null: false
      t.timestamps
    end
    
    add_index :posts, :post_id, unique: true
  end
end
