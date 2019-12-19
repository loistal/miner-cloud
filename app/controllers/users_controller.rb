class UsersController < ApplicationController

	def create 

		@user = User.new(user_params)

		if @user.save 
			flash[:now] = "Thanks for signing up!"
		else
			flash[:now] = "We couldn't create your account" 
		end

	end

	private 

	def user_params 
		params.require(:user).permit(:email, :password)

	end

end