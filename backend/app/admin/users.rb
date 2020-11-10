ActiveAdmin.register User do
  permit_params :email, :username
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :username, :email
  #
  # or
  #
  # permit_params do
  #   permitted = [:username, :email]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  form title: 'Form user' do |f|
    inputs 'Details' do
      input :username
      input :email
      li "Updated_at at #{f.object.updated_at}" unless f.object.new_record?
      li "Created at #{f.object.created_at}" unless f.object.new_record?
    end
    actions
  end

  controller do
    alias_method :destroy_user, :destroy

    def destroy
      user = User.find_by_id(params[:id])
      if user && !user.is_admin
        RoomMessage.where(user_id: user.id).delete_all
        destroy_user
      else
        flash[:danger] = "Admin users cannot be deleted!"
        redirect_to admin_users_path
      end
    end
  end
  
end
