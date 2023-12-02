class AddGenreToPosts < ActiveRecord::Migration[6.1]
  def change
    add_reference :posts, :genre, null: false, foreign_key: true
  end
end
