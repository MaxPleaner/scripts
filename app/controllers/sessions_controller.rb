class SessionsController < ApplicationController
  # Do not require login before login (loop)
  skip_before_action :require_login, :only => [:new, :create]
	def new
	end

  # Function to create a new session for a user
	def create
    # Authenticate user by email and password
		user = User.authenticate(params[:email], params[:password])
		if user
      		# Store session for user
			session[:user_id] = user.id
			# current_user
      		# Show page of all notes for user after successful login
			redirect_to notes_path
		else
			flash.now.alert = "Invalid username or password"
			render "new"
		end
	end

  # Function to end session after user logs out
	def destroy
		session[:user_id] = nil
		redirect_to root_url, :notice => "Logged out!"
	end
end

