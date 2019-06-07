class CreateCars < ActiveRecord::Migration[5.2]
  def change
    create_table :cars do |t|
      t.string :mark
      t.string :model
      t.decimal :price

      t.timestamps
    end
  end
end
