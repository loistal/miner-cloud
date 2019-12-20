class UsersController < ApplicationController

	def create 

		@user = User.new(user_params)

		if @user.save 
			redirect_to text_path
		else
			# do something
		end

	end

	private 

	def user_params 
		params.require(:user).permit(:email, :password)
	end

end