class AddDescriptionAndImageToBooks < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :description, :text
    add_column :books, :image, :string
  end
end
