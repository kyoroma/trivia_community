class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.text :posted_article, null: false
      t.string :tag_list
      t.timestamps
      t.integer :favorites_count
      t.boolean :published, default: false
      t.integer :genre_id, null: false

      t.index [:genre_id], name: "index_posts_on_genre_id"
    end
  end
end
