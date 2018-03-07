class AddReadToUserBooks < ActiveRecord::Migration[5.1]
  def change
    add_column :user_books, :read, :boolean, default: false
  end
end
