class AddAdminToUser < ActiveRecord::Migration[5.2]
  def up
    add_column :users, :is_admin, :boolean, :null => false, :default => false
  end

  def down
    remove_column :users, :is_admin
  end
end
