class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :discussion



  validates :content, presence: true
end
