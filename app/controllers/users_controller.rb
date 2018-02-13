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
      		redirect_to "/", :notice => "Logged in successfully 成功登录"
  		else
    # If user's login doesn't work, send them back to the login form.
    		redirect_to '/sign_in', :notice => "Please try login again 请再尝试登录"
		end
	end
	
	def show
		@users = User.all
		@books = @user.books.all.order('created_at DESC')
		@book_months = @books.group_by { |t| t.created_at.beginning_of_month }
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
			redirect_to '/', notice: "User does not exist 用户不存在"
		end	
	end

	def check_current_user
		if logged_in? and current_user.id != @user.id
			redirect_to "/", notice: "This is not your profile 这不是你的个人资料页
"
		elsif !logged_in?
			redirect_to "/", notice: "You need to log in first 你必须先登录"
		end	
	end

	def user_params
		params.require(:user).permit(:name, :email, :password, :role, :avatar, :remove_avatar, :auth_token)
	end
end