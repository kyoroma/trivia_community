class Post < ApplicationRecord
  has_one_attached :image

  #acts_as_taggable_on :tags

  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_by, through: :favorites, source: :user
  has_many :post_tags
  has_many :tags, through: :post_tags

  belongs_to :genre

  validates :posted_article, presence: true
  validates :published, inclusion: { in: [true, false] }


  def self.search(params)
    if params[:q].present? && params[:tag_id].present?
      keyword_search = where("posted_article LIKE ?", "%#{params[:q]}%")
      tag = Tag.find(params[:tag_id])
      tag_search = joins(:post_tags).where("post_tags.tag_id = ?", tag.id)
      posts = keyword_search.merge(tag_search)
    elsif params[:q].present?
      posts = where("posted_article LIKE ?", "%#{params[:q]}%")
    elsif params[:tag_id].present?
      tag = Tag.find(params[:tag_id])
      posts = joins(:post_tags).where("post_tags.tag_id = ?", tag.id)
    else
      posts = none
    end

    posts
  end

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end