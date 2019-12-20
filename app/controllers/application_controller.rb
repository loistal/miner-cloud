class ApplicationController < ActionController::Base
	helper_method :current_user, :logged_in?

	def current_user
		@current_user ||= User.find(session[:user_id]) if session[:user_id]
	end

	def logged_in?
		!!current_user
	end


	def require_user
		if !logged_in?
			flash[:danger] = "You must be logged in to perform that action"
			redirect_to login_path
		end
	end

	def difficulty_to_string(difficulty_int)
		case difficulty_int
		when 1
		  return "beginner"
		when 2
		  return "upper beginner"
		when 3
		  return "intermediate"
		when 4
		  return "upper intermediate"
		when 5
		  return "advanced"
		else
		  "Error with the level of difficulty"
		end
	end
end
