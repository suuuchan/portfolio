class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites
  attachment :image
  
  validates :title, presence: true, length: { minimum: 2, maximum: 10 }
  validates :text, presence: true, length: { minimum: 2, maximum: 50 }
  validates :image, presence: true
end
