class AddColumnToUsersLogic < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :deleted_at, :datetime, default: nil, null: true
  end
end
