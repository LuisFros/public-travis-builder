class AdminsessionsController < ApplicationController
  skip_before_action :authenticate_admin_user!, only: [:new, :create, :destroy]

  def new
    if logged_in?
      redirect_to admin_root_path
    end
  end

  def create
    #ENVIAR DATOS DE LOGIN A COGNITO
    #VER SI COGNITO AUTORIZA
    #REDIRIGIR A
    user = User.find_by(username: params[:username])
    if user && user.is_admin
      session[:user_id] = user.id
      redirect_to admin_root_path, notice: 'Logged in successfully!'
      # Log the user in and redirect to the admin dashboard
    else
      flash[:danger] = 'Invalid email/password combination' # Not quite right!
      render 'new'
    end
  end

  def destroy
    session.delete(:user_id)
    @current_user = nil
    redirect_to new_admin_user_session_path, notice: 'Logged out successfully!'
  end

end
