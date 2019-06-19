class HardAi
  def find_best_move(board)
    choices = get_available_choices(board)
    
  end
  def get_available_choices(board)
    available_choices = []
    board.each_with_index {|mark, position| available_choices << position if mark.nil?}
    available_choices
  end
end
