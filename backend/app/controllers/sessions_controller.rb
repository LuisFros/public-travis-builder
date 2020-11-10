class SessionsController < ApplicationController
  #skip_before_action :authorized, only: [:new, :create, :welcome]

  def new
    if logged_in?
      redirect_to '/rooms'
    end
  end

  def create
    @user = User.find_by(username: params[:username])
    if @user
      begin
        resp = Cognito.authenticate({USERNAME: params[:username], PASSWORD: "Password12?"}).authentication_result
      rescue => e
        resp = e
      end
      session[:access_token] = resp['access_token']
    else
      return render json: {"error": "usuario no encontrado"}
    end
  end

  def destroy
    if request.headers['Authorization']
      Cognito.sign_out(request.headers['Authorization'])
      resp = { type: 'success', message: 'now you are disconected' }
    else
      resp = { type: 'error', message: 'empty token' }
    end
    session.delete(:user_id)
    @current_user = nil
    redirect_to '/welcome'
    return render json: resp
  end

  def login
  end

  def welcome
    if logged_in?
      redirect_to '/rooms'
    end
  end
end
