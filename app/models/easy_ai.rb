class EasyAI
  def calculate_choices(board)
    available_choices = []
    board.each_with_index {|mark, position| available_choices << position if mark.nil?}
    available_choices
  end

  def move(board)
    choice = calculate_choices(board).sample
    h = {}
    h[choice] = "1"
    h
  end
end
