class Room < ApplicationRecord
  belongs_to :host, class_name: "User"
  has_one :tictactoe

  def curr_player?(user)
    self.tictactoe.player == player_num(user)
  end

  def player_num(user)
    self.host.username == user ? 0 : 1
  end
end
