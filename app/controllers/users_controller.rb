class UsersController < ApplicationController
	before_action :find_user, only: [:show, :edit, :update, :verify, :unverify]
	before_action :check_current_user, only: [:edit, :update]

	def create
		user = User.find_by_email(params[:user][:email])
    # If the user exists AND the password entered is correct.
    	if user && user.authenticate(params[:user][:password])
      # Save the user id inside the browser cookie. This is how we keep the user 
      # logged in when they navigate around our website.
      		if params[:user][:remember_me]
      			cookies.permanent[:auth_token] = user.auth_token
      		else
      			cookies[:auth_token] = user.auth_token
      		end	
      		redirect_to "/", :notice => "Logged in successfully"
  		else
    # If user's login doesn't work, send them back to the login form.
    		redirect_to '/sign_in', :notice => "Please try login again"
		end
	end
	
	def show
		@users = User.all
		@books = current_user.books.all.paginate(page: params[:page], per_page: 12).order('created_at DESC')
	end

	def edit
		@user = current_user
	end

	def update
		@user.update(user_params)
		redirect_to @user
	end

	private

	def find_user
		if @user = User.find_by(id: params[:id])
			return @user
		else
			redirect_to '/', notice: "User does not exist"
		end	
	end

	def check_current_user
		if logged_in? and current_user.id != @user.id
			redirect_to "/", notice: "This is not your profile"
		elsif !logged_in?
			redirect_to "/", notice: "You need to log in first"
		end	
	end

	def user_params
		params.require(:user).permit(:name, :email, :password, :role, :avatar, :remove_avatar, :auth_token)
	end
end