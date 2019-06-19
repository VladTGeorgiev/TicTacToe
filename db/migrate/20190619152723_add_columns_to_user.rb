class AddColumnsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :alias, :string
    add_column :users, :age, :integer
    add_column :users, :gender, :string
  end
end
