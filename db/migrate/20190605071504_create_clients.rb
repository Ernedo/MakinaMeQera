class CreateClients < ActiveRecord::Migration[5.2]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :email
      t.integer :tel
      t.string :drivinglicense

      t.timestamps
    end
  end
end
