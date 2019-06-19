class HardAi
  def find_best_move(board)
    choices = get_available_choices(board)
    best_move = choices[0]
    choices.each do |choice|
      calc_best(choice)
    end
    best_move
  end
  def get_available_choices(board)
    available_choices = []
    board.each_with_index {|mark, position| available_choices << position if mark.nil?}
    available_choices
  end

  def calc_best(choices)
    best_choice = nil
    choices.each do |choice|
      return 10 if Tictactoe.new.won?(choice)
      return 0 if Tictactoe.new.draw?(choice)
      return calc_best(choice) - 1
    end
  end


  def min_max(choices)
  end

  def draw?(board)
    board.none?(&:nil?)
  end

  def won_by?(boxes, player)
    i = player
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
