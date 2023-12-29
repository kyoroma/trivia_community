class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :post_images, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_posts, through: :favorites, source: :post
  has_many :comments, dependent: :destroy
  ## 名前を保存するためのカラムを追加
  validates :name, presence: true

  attribute :is_active, :boolean, default: true
  
  
  def guest?
    email == 'guest@example.com'
  end

  # ゲストユーザーを作成するメソッド
  def self.guest
    find_or_create_by(email: 'guest@example.com') do |user|
      user.name = 'Guest User'
      user.password = Devise.friendly_token[0, 20]
    end
  end

  def active_for_authentication?
    super && is_active?
  end
end
