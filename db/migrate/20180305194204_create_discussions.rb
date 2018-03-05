class CreateDiscussions < ActiveRecord::Migration[5.1]
  def change
    create_table :discussions do |t|
      t.string :topic
      t.integer :book_id

      t.timestamps
    end
  end
end
