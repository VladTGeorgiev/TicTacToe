class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.string :title
      t.text :text
      t.references :from, foreign_key: { to_table: :users }
      t.references :to, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
