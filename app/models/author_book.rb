class AuthorBook < ApplicationRecord
  belongs_to :authors
  belongs_to :books
  
end
