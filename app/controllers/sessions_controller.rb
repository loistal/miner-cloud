class SessionsController < ApplicationController

	before_action :logged_in_redirect, only: [:new, :create]
	skip_before_action :require_user

	# homepage
	def index

	end


	def create
		user = User.find_by(email: params[:session][:email])
		if user && user.authenticate(params[:session][:password])
			session[:user_id] = user.id
			flash[:now] = "You have successfully logged in"
			redirect_to root_path
		else
			puts "FAILED"
			flash.alert = "Something is wrong with the information you provided"
			redirect_to root_path
		end
	end

	def destroy
		session[:user_id] = nil
		# flash[:success] = "You have successfully logged out"
		redirect_to root_path
	end

	private
	def logged_in_redirect
		if logged_in?
			flash[:error] = "You are already logged in"
			redirect_to root_path
		end
	end

end
