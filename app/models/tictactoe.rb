class Tictactoe < ApplicationRecord
  belongs_to :room
  serialize :boxes, Array

  def next_turn(params)
    arr = boxes.dup
    params.each { |i, player| arr[i.to_i] = player }
    player = (self.player + 1) % 2
    update(boxes: arr, player: player)
  end
end
