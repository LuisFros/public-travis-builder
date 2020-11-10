class AddHiddenToRoomMessage < ActiveRecord::Migration[5.2]
  def up
    add_column :room_messages, :hidden, :boolean, :default => false
  end
  def down
    remove_column :room_messages, :hidden, :boolean, :default => false
  end
end
