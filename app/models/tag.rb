class Tag < ApplicationRecord
  has_many :book_tags
  has_many :books, through: :book_tags
  has_many :user_tags
  has_many :users, through: :user_tags


  validates :name, uniqueness: true
  validates :name, presence: true
  
end
