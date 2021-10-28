class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :diaries, dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :follower
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed

  has_many :favorites, dependent: :destroy
  has_many :favorite_posts, through: :favorites, source: :post

  validates :username, uniqueness: true
  validates :image, presence: true
  validates :nickname, presence: true, length: { minimum: 2, maximum: 10 }
  validates :username, presence: true, length: { minimum: 2, maximum: 100 }
  validates :crop, presence: true
  validates :introduction, presence: true, length: {maximum: 30 }
  attachment :image

  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    followings.include?(user)
  end

  def favorite(post)
    favorites.find_or_create_by(post: post)
  end

  def favorite?(post)
    favorite_posts.include?(post)
  end

  def unfavorite(post)
    favorite_posts.delete(post)
  end
end
