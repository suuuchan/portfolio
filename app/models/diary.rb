class Diary < ApplicationRecord
  belongs_to :user, class_name: "User"
  attachment :image
  validates :image, presence: true
  validates :title, presence: true
  validates :text, presence: true, length: {maximum: 100}
end
