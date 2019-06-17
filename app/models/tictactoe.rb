class Tictactoe < ApplicationRecord
  belongs_to :room
  serialize :boxes, Array
  serialize :history, Array

  def game_at(turn)
    self.history = history
    return nil if turn > history.length - 1 || turn  < -history.length

    arr = []

    history[0..turn].each do |move|
      player, box = move.split(",")
      arr[box.to_i] = player
    end
    arr
  end


  def next_turn(params)
    arr = self.boxes.dup
    new_history = self.history.dup
    params.each do |i, player|
      arr[i.to_i] = player
      new_history << "#{player},#{i}"
    end
    update(boxes: arr, history: new_history)
  end

  def next_player
    player = (self.player + 1) % 2
    update(player: player)
  end

  def over?
    return true if self.status != "active"
    return update(status: "#{self.player}") if won?
    return update(status: "draw") if draw?
    false
  end

  def draw?
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

    arr.any?
  end

end
