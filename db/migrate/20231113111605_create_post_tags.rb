class CreatePostTags < ActiveRecord::Migration[6.1]
  def change
    create_table :post_tags do |t|
      t.integer :post_tag_id, null: false
      t.integer :post_id, null: false
      t.integer :tag_id, null: false
      t.string :tag_list
      t.timestamps

      t.index :post_tag_id, unique: true
      t.index :post_id
      t.index :tag_id
    end
  end
end
