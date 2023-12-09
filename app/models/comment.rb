class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  belongs_to :commentable, polymorphic: true

  validates :comment, presence: true

  def genre
    commentable if commentable_type == 'Genre'
  end
end
