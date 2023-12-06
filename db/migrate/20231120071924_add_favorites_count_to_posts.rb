class AddFavoritesCountToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :favorites_count, :integer unless column_exists?(:posts, :favorites_count)
  end
end
