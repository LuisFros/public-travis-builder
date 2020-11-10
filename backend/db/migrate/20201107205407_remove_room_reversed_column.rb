class RemoveRoomReversedColumn < ActiveRecord::Migration[5.2]
  def self.up
    remove_column :rooms, :reversed
  end

  def self.down
    add_column :rooms, :reversed
  end
end
