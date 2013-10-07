class UsersController < ApplicationController

  # Do not require login when users want to sign up
  skip_before_action :require_login, :only => [:new, :create]

  def new
  	@user = User.new
  end

  def create
    @user = User.new(user_params)
  	if (@user.save)
      # Setting the session here allows users to login automatically after sign up
      session[:user_id] = @user.id
      # Send to page with all notes after user is logged in
    	redirect_to notes_path, :notice => "Signed up!"
  	else
    	render "new"
  	end
  end

  # Whitelists all fields the application will accept in creating a new User
  def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

    # Function to authenticate user with their email and password
  def authenticate(email, password)
    user = find_by(email: email)
    # Check salted password hash is correct
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
  
end





