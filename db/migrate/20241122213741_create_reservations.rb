class CreateReservations < ActiveRecord::Migration[7.1]
  def change
    create_table :reservations do |t|
      t.string :name
      t.string :phone
      t.integer :party_size
      t.datetime :start_time
      t.references :table, null: false, foreign_key: true

      t.timestamps
    end
    add_index :reservations, [:table_id, :start_time]
  end
end
