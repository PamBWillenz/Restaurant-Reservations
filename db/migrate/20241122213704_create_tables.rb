class CreateTables < ActiveRecord::Migration[7.1]
  def change
    create_table :tables do |t|
      t.integer :capacity
      t.string :name

      t.timestamps
    end
    add_index :tables, :name, unique: true
  end
end
