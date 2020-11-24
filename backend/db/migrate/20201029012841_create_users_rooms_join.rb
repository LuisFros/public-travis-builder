class CreateUsersRoomsJoin < ActiveRecord::Migration[5.2]
  def up
    create_table 'rooms_users', :id => false do |t|
      t.column 'user_id', :integer
      t.column 'room_id', :integer
    end
  end

  def down
    drop_table 'rooms_users'
  end
end
