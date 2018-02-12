class StaticController < ApplicationController

	def index
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			if params[:user][:remember_me]
      			cookies.permanent[:auth_token] = @user.auth_token
      		else
      			cookies[:auth_token] = @user.auth_token
      		end

      		redirect_to '/', :notice => "Sign up successfully"
		else
			redirect_to '/sign_up', :notice => "Please try sign up again and fill in all details correctly"
		end	
	end

	def destroy
		cookies.delete(:auth_token)
		redirect_to '/sign_in', :notice => "You have been signed out"
	end

	private

	def user_params
		params.require(:user).permit(:name, :email, :password, :role, :avatar, :remove_avatar, :auth_token)
	end
end
