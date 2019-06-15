class AddBoxesToTictactoes < ActiveRecord::Migration[5.2]
  def change
    add_column :tictactoes, :boxes, :text
  end
end
