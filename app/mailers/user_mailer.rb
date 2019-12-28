class UserMailer < ApplicationMailer

	def welcome_email(user)
    	@user = user
    	mail(to: @user.email, subject: 'A word from Lois Lin')
  	end

end
