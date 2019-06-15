class User < ApplicationRecord
    validates :username, uniqueness: true
    validates :username, length: { minimum: 3 }
end
