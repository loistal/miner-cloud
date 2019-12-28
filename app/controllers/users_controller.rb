class UsersController < ApplicationController

	def create 

		@user = User.new(user_params)

		if @user.save 
			UserMailer.welcome_email(@user).deliver_now
			redirect_to text_path
		else
			# do something
		end

	end

	def account 
		@indexAt = current_user.email.index("@")
		@username = current_user.email[0, @indexAt]

		@total_sentences = Card.where(user_id: current_user.id).count
		@number_of_texts = Article.where(user_id: current_user.id).count 
		@long_term_mem = Card.where("stage >= 8 AND stage < 10 AND user_id = ?", current_user.id).count
		@short_term_mem = Card.where("stage >= 0 AND stage < 8 AND user_id = ?", current_user.id).count
	end

	private 

	def user_params 
		params.require(:user).permit(:email, :password)
	end

end