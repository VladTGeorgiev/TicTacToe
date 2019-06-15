class Tictactoe < ApplicationRecord
  belongs_to :room
  serialize :boxes, Array

  def next_turn(params)
    arr = boxes.dup
    params.each { |i, player| arr[i.to_i] = player }
    update(boxes: arr)
  end

  def next_player
    player = (self.player + 1) % 2
    update(player: player)
  end

  def draw?
    update(status: "won") if self.boxes.size == 9 && self.boxes.none?(&:nil?)
    self.boxes.size == 9 && self.boxes.none?(&:nil?)
  end

  def won?
    i = self.player.to_s
    boxes = self.boxes
    arr = []
    arr.<<(boxes[0] == i && boxes[0] == boxes[1] && boxes[0] == boxes[2])
       .<<(boxes[0] == i && boxes[0] == boxes[3] && boxes[0] == boxes[6])
       .<<(boxes[0] == i && boxes[0] == boxes[4] && boxes[0] == boxes[8])
       .<<(boxes[1] == i && boxes[1] == boxes[4] && boxes[1] == boxes[7])
       .<<(boxes[2] == i && boxes[2] == boxes[4] && boxes[2] == boxes[6])
       .<<(boxes[2] == i && boxes[2] == boxes[5] && boxes[2] == boxes[8])
       .<<(boxes[3] == i && boxes[3] == boxes[4] && boxes[3] == boxes[5])
       .<<(boxes[6] == i && boxes[6] == boxes[7] && boxes[6] == boxes[8])

    update(status: "#{player}") if arr.any?
    arr.any?
  end

end
