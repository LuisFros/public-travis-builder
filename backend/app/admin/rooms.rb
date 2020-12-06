ActiveAdmin.register Room do
  permit_params :name, :private_room, :user_id
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :private_room, :user_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :reversed, :private_room, :user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  controller do
    after_create :set_user_id

    def set_user_id(room)
      owner = User.find_by_id(resource.user_id)
      if !room.user_id || !owner
        room.user_id = current_admin_user.id
        room.save
        if room.private_room
          current_admin_user.rooms << room
        end
      end
      #room.original_msg = room_message.message
      #room.save
    end
  end

  batch_action :send_message_to_rooms, form: {
                                              comment: :text
                                            } do |ids, inputs|
    # load selected rooms
    rooms = Room.find(ids) # selected rooms

    # Send message to rooms array

    if !inputs[:comment].empty?
      msg = inputs[:comment]
      rooms.each do |room_i|
        roommessage = RoomMessage.create(user_id: current_admin_user.id,
          room_id: room_i.id, message: msg, original_msg: msg
          )
      end
      # return to admin/rooms#index
      redirect_to collection_path, notice: 'Sent massive message'
    else
      # failed sending message by empty message
      redirect_to collection_path, notice: 'Blank input text: massive message was not sent'
    end
  end

  member_action :lock, method: :post do
    resource.private_room = !resource.private_room
    resource.save
    owner = User.find_by_id(resource.user_id)
    assigned_owner = false
    if resource.private_room
      if owner
        assigned_owner = true
        owner.rooms << resource
      end
      RoomMessage.joins(:room).joins(:user).where(room_id: resource.id).select('users.id, users.username').distinct.each do |w|
        user = User.find(w.id)
        user.rooms << resource
        if !owner
          owner = user
        end
      end
    end
    if !owner
      resource.user_id = current_admin_user.id
    else
      resource.user_id = owner.id
    end
    resource.save
    redirect_to resource_path, notice: "Privacy has been changed!"
  end

  form title: 'Form Room' do |f|
    inputs 'Details' do
      input :name
      #f.input :name => 'authenticity_token', :type => :hidden, :value => form_authenticity_token.to_s
      #f.input :room_id, as: :select, collection: Room.all
      f.input :user_id, as: :select, collection: User.all unless !f.object.new_record?
      input :private_room
      li "Updated_at at #{f.object.updated_at}" unless f.object.new_record?
      li "Created at #{f.object.created_at}" unless f.object.new_record?
    end
    actions
  end

  show do
    panel "Participants" do
      table_for RoomMessage.joins(:room).joins(:user).where(room_id: room.id).select('users.id, users.username').distinct do
        column :id
        column :username
        column do |p| link_to "View", admin_user_path(p) end
      end
    end
    panel "Room messages" do
      table_for room.room_messages do
        column :message
        column :id
        column do |p| link_to "View message", admin_room_message_path(p) end
        column :user_id
        column do |p| link_to "View user", admin_user_path(p.user_id) end
        # ...
      end
    end
  end
  sidebar "Room Information", only: [:show, :edit] do
    attributes_table_for room do
      row :name
      row :user_id
      row :private_room
    end
  div do
    link_to("Cambiar privacidad", lock_admin_room_path(params[:id]), :method => :post)
  end
  end
end
