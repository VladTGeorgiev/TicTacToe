class User < ApplicationRecord
  has_many :hosted_rooms, foreign_key: :host_id, class_name: "Room"
  has_many :visited_rooms, foreign_key: :opponent_id, class_name: "Room"
  validates :username, uniqueness: true, length: { minimum: 3 }
  has_secure_password

  def rooms
    self.hosted_rooms + self.visited_rooms
  end

  def playing?
    self.rooms.map(&:status).any? {|status| status == "active"}
  end
end
