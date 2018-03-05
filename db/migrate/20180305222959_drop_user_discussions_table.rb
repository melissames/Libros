class DropUserDiscussionsTable < ActiveRecord::Migration[5.1]
  def change
   drop_table :user_discussions
  end
end
