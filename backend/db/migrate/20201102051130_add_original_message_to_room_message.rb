class AddOriginalMessageToRoomMessage < ActiveRecord::Migration[5.2]
  def up
    add_column :room_messages, :original_msg, :text
  end
  def down
    remove_column :room_messages, :original_msg, :text
  end
end
