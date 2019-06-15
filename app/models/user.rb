class User < ApplicationRecord
  has_one :room
  validates :username, uniqueness: true
  validates :username, length: { minimum: 3 }
end
