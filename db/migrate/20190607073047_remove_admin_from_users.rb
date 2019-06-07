class RemoveAdminFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_columns :users, :admin
  end
end
