class Tictactoe < ApplicationRecord
  belongs_to :room
  serialize :boxes, Array
end
