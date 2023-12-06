class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.integer :user_id, null: false
      t.integer :post_id, null: false
      t.string :comment
      t.timestamps

      #t.index :comment_id, unique: true
      t.index :user_id
      t.index :post_id
    end
  end
end
