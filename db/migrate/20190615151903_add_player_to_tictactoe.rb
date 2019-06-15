class AddPlayerToTictactoe < ActiveRecord::Migration[5.2]
  def change
    add_column :tictactoes, :player, :integer
  end
end
