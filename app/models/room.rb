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

  def versus(user)
    return nil if user != host && user != opponent
    user == host ? opponent : host
  end

  def won_by?(user)
    return nil if user != host && user != opponent
    return true if user == host && won_by_host?
    return true if user == opponent && won_by_visitor?
    false
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
