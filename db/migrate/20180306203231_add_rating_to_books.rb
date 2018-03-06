class AddRatingToBooks < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :rating, :float
  end
end
