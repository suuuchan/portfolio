class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  attachment :image
end
