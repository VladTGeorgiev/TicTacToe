class EasyAi
  def calculate_choices(board)
    available_choices = []
    board.each_with_index {|mark, position| available_choice << postion if mark.nil?}
    available_choices
  end

  def move(board)
    calculate_choices(board).sample
  end
end
