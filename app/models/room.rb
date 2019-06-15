class Room < ApplicationRecord
  belongs_to :host, class_name: "User"
  has_one :tictactoe

  def curr_player?(user)
    player = (self.host.username == user ? 0 : 1)
    self.tictactoe.player == player
  end
end
