class CreateTictactoes < ActiveRecord::Migration[5.2]
  def change
    create_table :tictactoes do |t|
      t.references :room, foreign_key: true
      t.string :status
    end
  end
end
