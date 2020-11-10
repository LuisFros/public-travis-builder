class ApiController < ActionController::API
  include ActionController::RequestForgeryProtection
  #before_action :authorized
  helper_method :current_user
  helper_method :logged_in?
  after_action :custom_headers

  def custom_headers
    if Rails.env.production? 
      require 'net/http'
      url = URI.parse('http://169.254.169.254/latest/meta-data/instance-id')
      req = Net::HTTP::Get.new(url.to_s)
      res = Net::HTTP.start(url.host, url.port) {|http|
        http.request(req)
      }
      response.headers['X-Fowarded-instance-id']=res.body
    end
  end

  def current_user
    decoded = JWT.decode request.headers["Authorization"], nil, false
    User.find_by(username: decoded[0]["email"])
  end

end

class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true

  before_action :authenticate_admin_user!
  #auto_session_timeout Rails.configuration.session_timeout_length
  
  #has to be after auto_session_timeout so that prepend will not be overwritten.
  #protect_from_forgery with: :exception, prepend: true
  # your code here

  def logged_in?
    !current_admin_user.nil? && current_admin_user.is_admin
  end

  def authenticate_admin_user!
    redirect_to new_admin_user_session_path unless logged_in?
  end

  def manage_auth
    decoded = JWT.decode request.headers["Authorization"], nil, false
    user_email = decoded[0]["email"]
    user = User.find_by(username: user_email)
    if !user
      parameters = ActionController::Parameters.new({
        user: {
          username: user_email,
          password: "password"
        }
      })
      @user = User.create(parameters.require(:user).permit(:username, :password))
    end
  end
  
end
