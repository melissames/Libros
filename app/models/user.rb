class User < ApplicationRecord
  has_secure_password

  validates :name, uniqueness: { case_sensitive: false }

  has_many :user_books
  has_many :comments
  has_many :books, through: :user_books
  has_many :discussions, through: :comments

  has_many :user_tags
  has_many :tags, through: :books


  def bookshelf
    self.books
  end

  def add_to_reading_list(book)
    @user_book = UserBook.create(book_id: book.id, user_id: self.id)
  end

  def read_book(user_book, rating)
    byebug
    user_book.update(read: true, user_rating: rating)
  end

  def rate_book

  end

end
