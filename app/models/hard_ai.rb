class HardAi
  def move(board)
    choice = nil
    val = nil
    board.each_with_index do |check, pos|
      if check.nil?
        new_val = min_max(pos, board, "1")
        if choice.nil?
          choice = pos
          val = new_val
        else
          if new_val > val
            choice = pos
            val = new_val
          end
        end
      end
    end
    h = {}
    h[choice] = "1"
    h
  end


  def min_max(choice, board, player)
    board = board.dup
    board[choice] = player
    if player == "1"
      return 10 if won_by?(board, player)
    else
      return -10 if won_by?(board, player)
    end
    return 0 if draw?(board)
    choice = nil
    val = nil
    board.each_with_index do |check, pos|
      if check.nil?
        new_val = min_max(pos, board, (player == "1" ? "0" : "1")) + 1
        if choice.nil?
          choice = pos
          val = new_val
        else
          if new_val < val
            choice = pos
            val = new_val
          end
        end
      end
    end
    return val
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
