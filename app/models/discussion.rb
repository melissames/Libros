class Discussion < ApplicationRecord
  has_many :user_discussions
  has_many :users, through: :user_discussions
  belongs_to :book

  validates :topic, presence: true
end
