class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      t.string :name
      t.boolean :reversed, :default => false

      t.timestamps
    end
    add_index :rooms, :name, unique: true
  end
end
