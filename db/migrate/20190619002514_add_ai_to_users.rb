class AddAiToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :ai, :boolean
  end
end
