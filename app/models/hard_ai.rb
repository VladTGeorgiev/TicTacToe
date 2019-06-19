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

  def calc_best(choice)

  end
end
