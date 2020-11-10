class RoomsController < ApplicationController
  #skip_before_action :authorized
  # Loads:
  # @rooms = all rooms
  # @room = current room when applicable
  before_action :load_entities


  def index
    @rooms = Room.where(private_room: 'false')
    json = Rails.cache.fetch(Room.cache_key(@rooms)) do 
      @rooms
    end
    render json: json
  end

  def new
    @room = Room.new
  end

  def create
    room_name = params[:name]
    private_room = params[:private_room]
    if Room.find_by name: room_name
      return render json: {
        "error": "Another room already has that name"
      }
    else
      puts current_user.id
      @room = Room.create({
        name: room_name,
        private_room: private_room,
        user_id: current_user.id,
    })
      if @room.save
        # if room is created as a private one, we make user join room automatically.
        if private_room
          puts "ROOM IS PRIVATE. ADDING ROOM TO"
          puts current_user
          #current_user = User.find_by(id: params[:user_id])
          current_user.rooms << @room
          puts current_user.rooms
        end
        render json: @room
      else
        return render json: {
          "error": "error creating room."
        }
      end
    end
  end

  def edit
  end

  def update
    if @room.update_attributes(permitted_parameters)
      flash[:success] = "Room #{@room.name} was updated successfully"
      redirect_to rooms_path
    else
      render :new
    end
  end

  def show
    room = Room.find_by(id: params[:id])
    if room
      messages = RoomMessage.joins(:room).joins(:user).where(room_id: params[:id], hidden: false)
        .select('room_messages.id, room_messages.room_id, room_messages.user_id, room_messages.message,'\
          'room_messages.created_at, room_messages.updated_at, users.username, users.thumbnail_url'
        )
      # render json: {
      #   "room": room,
      #   "messages": messages
      # }
      json = Rails.cache.fetch('messages') do
        {
          "room": room,
          "messages": messages
        }
      end
    else
      return render json: {
        "error": "room not found"
      }
    end
    render json: json
  end

  def getroommessagespdf
    room = Room.find_by(id: params[:room_id])
    if room
      data = {
        "room": room,
        "messages": room.room_messages.map {
           |msg| {
              "message": msg.message,
              "created_at": msg.created_at,
              "author": msg.user.username
              }
          }
      }
      url_pdf = get_pdf_url(data)
      return render json: {
        "url_pdf": url_pdf
      }
    else
      return render json: {
        "error": "#noroom"
      }
    end
  end

  def get_pdf_url(data)
    form_data = {"data": data}
    form_data = form_data.to_json

    response = HTTParty.post("https://9x3j0lz3cc.execute-api.us-east-1.amazonaws.com/dev/api/htmltopdf", {
      body: form_data,
      headers: {
        'Content-Type' => 'application/json',
        'x-api-key': ENV["AWS_API_HTMLTOPDF_KEY_ID"]
      }
    })
    response_body = JSON.parse(response.body)
    return response_body["url_pdf"]
  end

  def private
    #current_user = User.find_by(id: params[:user_id])
    private_rooms = current_user.rooms
    return render json: {
      "privaterooms": private_rooms
    }
  end
  protected

  def load_entities
    @rooms = Room.all
    @room = Room.find(params[:id]) if params[:id]
  end

  def permitted_parameters
    params.permit(:name, :private_room, :user_id)
  end
end
