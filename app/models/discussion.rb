class Discussion < ApplicationRecord
  has_many :comments
  has_many :users, through: :comments
  belongs_to :book

  validates :topic, presence: true
end
