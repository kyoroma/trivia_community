class AddGenreIdToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :genre_id, :integer
    add_index :posts, :genre_id
  end
end
