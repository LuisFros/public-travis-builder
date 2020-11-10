class RoomMessagesController < ApiController
  #before_action :load_entities
  skip_before_action :authorized

  def create;  end

  def new_message
    if !params[:room_id] || !params[:user_id]
      return render json: {
        "error": "room_id or user_id parameters not detected"
    }
    end
    room = Room.find_by(id: params[:room_id])
    current_user = User.find_by(id: params[:user_id])

    if !room || !current_user
      return render json:{
        "error": "room or current user doesn't exist."
      }
    end
    received_message = params[:message]
    if is_username_mentioned(received_message)
      mention = get_username_mention(received_message)
      puts "---------------------------------"
      puts "mention:"
      puts mention
      user_mentioned = User.find_by(username: mention)
      if user_mentioned
        puts "user found."
        puts user_mentioned.username
        if user_mentioned.email
          puts "calling lambda function"
          send_email_mention(user_mentioned, room.name, received_message, user_mentioned.email)
        end
      else
        puts "user not found"
      end
    else
      puts "---------------"
      puts "no mention"
    end
    message = RoomMessage.create user: current_user, room: room, message: params[:message], original_msg: params[:message]
    room_messages = RoomMessage.joins(:room).joins(:user)
      .where(room_id: params[:room_id], hidden: false)
      .select('room_messages.id, room_messages.room_id, room_messages.user_id, room_messages.message,'\
        'room_messages.created_at, room_messages.updated_at, users.username'
        )

    return render json: {
      "status": "message created",
      "room_messages": room_messages
    }
  end

  def is_username_mentioned(message)
    message_split = params[:message].split()
    message_split.each do |message|
      if message.start_with?("@")
        return true
      end
    end
    return false
  end
  
  # https://aws.amazon.com/premiumsupport/knowledge-center/lambda-send-email-ses/
  def send_email_mention(user, room_info, received_message, to_email)
    client = Aws::Lambda::Client.new(region: 'us-east-1')
    req_payload = {
      :email => user.email,
      :room_name => room_info,
      :received_message => received_message,
      :to_email => to_email
    }
    payload = JSON.generate(req_payload)
    puts "payload: "
    puts payload
    resp = client.invoke({
                          function_name: 'sendEmailFunction',
                        #  invocation_type: 'RequestResponse',
                          invocation_type: 'Event',
                         log_type: 'None',
                         payload: payload
                       })
    # resp_payload = JSON.parse(resp.payload.string)
    # puts resp_payload
  end

  def get_username_mention(message)
    message_split = params[:message].split()
    message_split.each do |message|
      if message.start_with?("@")
        return message.last(-1)
      end
    end
  end

  protected

  def load_entities
    @room = Room.find params.dig(:room_message, :room_id)
  end
end
