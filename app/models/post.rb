class Post < ApplicationRecord
  validates :user_id, presence: true
  validates :category_id, presence: true
  validates :title, presence: true
  validates :content, presence: true
  validates :content, length: {minimum: 5}
  
  belongs_to :user
  belongs_to :category

  has_many :comments
end
