class AddDefaultToPublishedInPosts < ActiveRecord::Migration[6.1]
  def change
    change_column_default :posts, :published, false
  end
end
