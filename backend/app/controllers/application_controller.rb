class ApplicationController < ActionController::API
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

  def logged_in?
    !current_user.nil?
  end

  def authorized
    redirect_to '/welcome' unless logged_in?
  end

  def manage_auth
    decoded = JWT.decode request.headers["Authorization"], nil, false
    user_email = decoded[0]["email"]
    validator = GoogleIDToken::Validator.new
    validated = validator.check(request.headers["Authorization"], decoded[0]['aud'], "343317939754-2g02mvq4pgoji7il8j2bh9gmphi0vbnl.apps.googleusercontent.com")
    if validated
      puts "token has been validated by backend"
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
  
end
