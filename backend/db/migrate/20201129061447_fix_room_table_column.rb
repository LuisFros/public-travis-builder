class FixRoomTableColumn < ActiveRecord::Migration[5.2]
  def self.up
    rename_column :rooms, :reversed, :hidden
  end

  def self.down
    rename_column :rooms, :hidden, :reversed
  end
end