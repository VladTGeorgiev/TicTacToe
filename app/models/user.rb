class User < ApplicationRecord
  has_one :room
  validates :username, uniqueness: true, length: { minimum: 3 }
  has_secure_password

end
