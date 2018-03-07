class AddUserRatingToUserBooks < ActiveRecord::Migration[5.1]
  def change
    add_column :user_books, :user_rating, :float
  end
end
