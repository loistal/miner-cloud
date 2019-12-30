class PasswordsController < ApplicationController

	def forgot
	    if params[:user][:email].blank? 
	    	render json: {error: 'Email not present'}
		end

    	user = User.find_by(email: params[:user][:email]) 

	    if user.present?
	    	user.generate_password_token! #generate pass token

	    	# send email with token
	    	UserMailer.reset_password(user, user.reset_password_token).deliver_now

	    	render json: {status: 'ok'}, status: :ok
	    else
	    	render json: {error: ['Email address not found. Please check and try again.']}, status: :not_found
	    end
	end


	def reset_page

		token = params[:token].to_s

		if params[:email].blank?
			return render json: {error: 'Email not present'}
		end

		user = User.find_by(reset_password_token: params[:token].to_s)

		if user.present? && user.password_token_valid?
			redirect_to reset_page_path
		else
			render json: {error:  ['Link not valid or expired. Try generating a new link.']}, status: :not_found
		end 
	end



	def reset
		token = params[:token].to_s

		if params[:email].blank?
			return render json: {error: 'Email not present'}
		end

		user = User.find_by(reset_password_token: token)

		if user.present? && user.password_token_valid?
			if user.reset_password!(params[:password])
				render json: {status: 'ok'}, status: :ok
			else
				render json: {error: user.errors.full_messages}, status: :unprocessable_entity
			end
		else
			render json: {error:  ['Link not valid or expired. Try generating a new link.']}, status: :not_found
		end
	end


	private 

	def reset_params
      params.require(:person).permit(:name, :age)
    end

end
