class AddPrivateToRooms < ActiveRecord::Migration[5.2]
  def up
    add_column :rooms, :private_room, :boolean, :default => false
  end
  def down
    remove_column :rooms, :private_room, :boolean
  end
end
