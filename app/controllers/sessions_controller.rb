class SessionsController < ApplicationController

	before_action :logged_in_redirect, only: [:new, :create]

	# homepage
	def index
		
	end


	def create 
		user = User.find_by(email: params[:session][:email])
		if user && user.authenticate(params[:session][:password])
			session[:user_id] = user.id 
			# flash[:success] = "You have successfully logged in"
			redirect_to root_path 
		else
			# flash[:now] = "Something is wrong with the information you provided"
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