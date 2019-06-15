class Room < ApplicationRecord
  belongs_to :host, class_name: "User"
  has_one :tictactoe
end
