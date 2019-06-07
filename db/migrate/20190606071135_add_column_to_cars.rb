class AddColumnToCars < ActiveRecord::Migration[5.2]
  def change
    add_column :cars, :deleted_at, :datetime, default: nil, null: true
  end
end
