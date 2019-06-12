class AddUsersToPhoto < ActiveRecord::Migration[5.2]
  def change
    add_column :photos, :user_id, :bigint, index: true, null: false, foreign_key: true
  end
end
