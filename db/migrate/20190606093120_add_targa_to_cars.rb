class AddTargaToCars < ActiveRecord::Migration[5.2]
  def change
    add_column :cars, :targa, :string, null: false
  end
end
