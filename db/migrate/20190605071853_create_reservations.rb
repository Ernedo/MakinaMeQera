class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.date :start_date
      t.date :end_date
      t.decimal :price
      t.belongs_to :car, foreign_key: true
      t.belongs_to :client, foreign_key: true

      t.timestamps
    end
  end
end
