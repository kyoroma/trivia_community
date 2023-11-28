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

  def is_active
    true
  end

  # ゲストユーザーを作成するメソッド
  def self.create_guest
    create!(
      name: "ゲストユーザー",
      email: "guest@example.com",
      password: SecureRandom.hex(10)
    )
  end
end
