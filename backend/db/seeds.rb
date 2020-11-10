# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# This file should contain all the record creation needed to seed the database
# with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
# Write the code in a way that can be executed multiple times without duplicating the information.
#
# For example:
#
# Country.create(name: "Chile") # BAD
# Country.find_or_create_by(name: "Chile") # GOOD
#

num_users = 10
user_data = (1..num_users).map do |num|
  {
    username: "user#{num}",
    email: '123456',
    is_admin: num == 1
  }
end

public_rooms_data = (1..2).map do |num|
  {
    name: "room#{num}",
    user_id: rand(1..num_users)
  }
end

private_rooms_data = (1..2).map do |num|
  {
    name: "roomprivate#{num}",
    private_room: true,
    user_id: rand(1..num_users)
  }
end

# Create user instances
users = User.create(user_data)
puts "Added #{User.all.count} users"
public_rooms = Room.create(public_rooms_data)
puts "Added #{public_rooms.length} public rooms"
private_rooms = Room.create(private_rooms_data)
puts "Added #{private_rooms.length} private rooms"

public_rooms.each do |room_i|
  (0..3).each do |_i|
    (1..5).each do |j|
      msg = (0...8).map { (65 + rand(26)).chr }.join
      roommessage = RoomMessage.create(user_id: j,
                            room_id: room_i.id, message: msg, original_msg: msg
                            )
      puts "Added message id #{roommessage.id} message #{roommessage.message} room: #{room_i.id} useri: #{j} ORIGINAL_MSG #{roommessage.original_msg}"
    end
  end
end
puts "Added #{RoomMessage.all.count} room messages"

private_rooms.each do |room_i|
  puts "#{room_i.user_id} == #{users[room_i.user_id-1].id} ??"
  users[room_i.user_id-1].rooms << room_i
  (num_users-2..num_users-1).each do |i|
    msg = "nadie vera mi clave muahaha" + (0...8).map { (65 + rand(26)).chr }.join
    users[i].rooms << room_i
    roommessage = RoomMessage.create(user_id: users[i].id,
                          room_id: room_i.id, message: msg, original_msg: msg
                          )
    puts "Added message id #{roommessage.id} message #{roommessage.message} room: #{room_i.id} useri: #{users[i].id} ORIGINAL_MSG #{roommessage.original_msg}"
  end
end
