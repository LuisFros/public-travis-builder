class ApiController < ActionController::API
  include ActionController::Cookies
  include ActionController::RequestForgeryProtection
  include ApplicationHelper
  protect_from_forgery prepend: true
  before_action :authorized
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

  def authorized
    redirect_to '/welcome' unless logged_in?
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

  def valid_token?
    token = session[:access_token]
    decoded_body = Base64.decode64(token.split('.')[1])
    parsed_json = ActiveSupport::JSON.decode(decoded_body)
    begin
      username = parsed_json["username"]
      return username
    rescue => e
      return false
    end
  end

  def authorized
    redirect_to '/welcome' unless logged_in?
  end

  def authenticate_admin_user!
    redirect_to new_admin_user_session_path unless logged_in?
  end

  def current_admin_user
    User.find_by(id: session[:user_id])
  end
end