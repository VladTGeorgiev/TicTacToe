class CreateLeaderboards < ActiveRecord::Migration[5.2]
  def change
    create_table :leaderboards do |t|

      t.timestamps
    end
  end
end
