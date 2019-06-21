class AddColumnHistoryToTictactoe < ActiveRecord::Migration[5.2]
  def change
    add_column :tictactoes, :history, :text
  end
end
