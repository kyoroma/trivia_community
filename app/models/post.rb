class Post < ApplicationRecord
  has_one_attached :image # 画像をアップロードするための設定

  has_many :favorites, dependent: :destroy
  has_many :favorited_by, through: :favorites, source: :user
  
  counter_culture :favorites

  validates :posted_article, presence: true
  validates :tag_list, presence: true
end
