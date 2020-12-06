class UsersController < ApiController
  before_action :manage_auth
  
  def new
    if logged_in?
      redirect_to '/rooms'
    end
    @user = User.new
  end

  def create
    parameters = ActionController::Parameters.new({
      user: {
        username: "",
        password: "password"
      }
    })
    if params[:anon] == "true"
      parameters[:user][:username] = "anon" + SecureRandom.hex(15)
    else
      parameters[:user][:username] = params[:username]
    end
    @user = User.create(parameters.require(:user).permit(:username))
    render json: @user 
  end

  def set_email
    user = User.find_by(id: params[:id])
    if user
      user.update_attributes(:email => params[:email])
      return render json: user
    else
      return render json: {
        "error": "user not found"
      }
    end
  end

  def getdata
    puts "getting user data"
    puts request.headers['Authorization']
    puts JWT.decode request.headers['Authorization'], nil, false
  end
end
