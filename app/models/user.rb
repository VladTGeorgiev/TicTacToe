class User < ApplicationRecord
  has_many :hosted_rooms, foreign_key: :host_id, class_name: "Room"
  has_many :visited_rooms, foreign_key: :opponent_id, class_name: "Room"
  has_one_attached :avatar
  validates :username, uniqueness: true, length: { minimum: 3 }
  validates :password, length: {minimum: 3}
  has_secure_password

  def rooms
    self.hosted_rooms + self.visited_rooms
  end

  def playing?
    return false if self.ai
    self.rooms.map(&:status).any? {|status| status == "active"}
  end

  def wins
    self.hosted_rooms.select(&:won_by_host?) + self.visited_rooms.select(&:won_by_visitor?)
  end

  def loses
    self.hosted_rooms.select(&:won_by_visitor?) + self.visited_rooms.select(&:won_by_host?)
  end

  def draws
    rooms.select(&:draw?)
  end

  def past_rooms
    result = rooms
    result -= [curr_room] if curr_room
    result.sort_by(&:created_at)
  end

  def curr_room
    rooms.find(&:active?)
  end

  def total
    wins + loses + draws
  end

  def ratio
    if total.length == 0
      nil
    else
      (wins.length.to_f/total.length.to_f).round(2)
    end
  end


end
