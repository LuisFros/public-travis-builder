class AddColumnCreatorRooms < ActiveRecord::Migration[5.2]
  def up
    add_column :rooms, :user_id, :integer
  end
  def down
    remove_column :rooms, :user_id, :integer
  end
end
