class AdminsessionsController < ApplicationController
  skip_before_action :authenticate_admin_user!, only: [:new, :create, :destroy]

  def new
  end

  def destroy
    cookies[:user_id] = {value: 0, expires: Time.now}
    @current_user = nil
    redirect_to new_admin_user_session_path, notice: 'Logged out successfully!'
  end

  def create
    if user = authenticate_with_google
      cookies.signed[:user_id] = user.id
      redirect_to admin_dashboard_path
    else
      redirect_to new_admin_user_session_path, alert: 'authentication_failed'
    end
  end

  private
  
  def authenticate_with_google
    if id_token = flash[:google_sign_in]['id_token']
      User.find_by email: GoogleSignIn::Identity.new(id_token).email_address
    elsif error = flash[:google_sign_in][:error]
      logger.error "Google authentication error: #{error}"
      nil
    end
  end

end
