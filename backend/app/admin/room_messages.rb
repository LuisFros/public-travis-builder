ActiveAdmin.register RoomMessage do
  permit_params :message, :hidden, :room_id, :user_id
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :room_id, :user_id, :message, :hidden, :original_msg
  #
  # or
  #
  # permit_params do
  #   permitted = [:room_id, :user_id, :message, :hidden, :original_msg]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  controller do
    after_create :keep_original_msg

    def keep_original_msg(room_message)
      room_message.original_msg = room_message.message
      room_message.save
    end
  end
  
  form title: 'Form message' do |f|
    inputs 'Details' do
      input :message
      input :hidden
      #f.input :name => 'authenticity_token', :type => :hidden, :value => form_authenticity_token.to_s
      f.input :room_id, as: :select, collection: Room.all unless !f.object.new_record?
      f.input :user_id, as: :select, collection: User.all unless !f.object.new_record?
      li "original msg: #{f.object.original_msg}" unless f.object.new_record?
      li "Created at #{f.object.created_at}" unless f.object.new_record?
    end
    actions
  end

end
