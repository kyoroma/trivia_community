class Post < ApplicationRecord
  has_one_attached :image # 画像をアップロードするための設定

  has_many :posts, counter_cache: true
  has_many :favorites, dependent: :destroy
  has_many :favorited_by, through: :favorites, source: :user

  belongs_to :genre

  validates :posted_article, presence: true
  validates :tag_list, presence: true
  validates :published, inclusion: { in: [true, false] }

end
