class Book < ApplicationRecord
  has_many :discussions
  has_many :user_books
  has_many :author_books
  has_many :users, through: :user_books
  has_many :authors, through: :author_books

end
