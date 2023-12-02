class Post < ApplicationRecord
  has_one_attached :image

  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_by, through: :favorites, source: :user

  belongs_to :genre
  acts_as_taggable_on :tags

  validates :posted_article, presence: true
  validates :tag_list, presence: true
  validates :published, inclusion: { in: [true, false] }
end
