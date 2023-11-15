class Post < ApplicationRecord
  has_one_attached :image # 画像をアップロードするための設定
  
  validates :posted_article, presence: true
  validates :tag_list, presence: true
end
