class Room < ApplicationRecord
  belongs_to :host, class_name: "User"
  belongs_to :opponent, class_name: "User"
  has_one :tictactoe

  def curr_player?(user)
    self.tictactoe.player == player_num(user)
  end

  def player_num(user)
    self.host.username == user ? 0 : 1
  end

  def status
    self.tictactoe.status
  end
  

  def active?
    self.tictactoe.status == "active"
  end

  def won_by_host?
    status == "0"
  end

  def won_by_visitor?
    status == "1"
  end

  def draw?
    status == "draw"
  end
end
