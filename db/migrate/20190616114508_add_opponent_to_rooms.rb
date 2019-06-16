class AddOpponentToRooms < ActiveRecord::Migration[5.2]
  def change
    add_reference :rooms, :opponent, foreign_key: { to_table: :users }
  end
end
