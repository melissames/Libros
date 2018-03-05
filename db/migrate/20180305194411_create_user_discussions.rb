class CreateUserDiscussions < ActiveRecord::Migration[5.1]
  def change
    create_table :user_discussions do |t|
      

      t.timestamps
    end
  end
end
