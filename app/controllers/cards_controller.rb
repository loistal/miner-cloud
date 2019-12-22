class CardsController < ApplicationController

	def index
		
	end

	# create a new card
	def create
		@card = Card.new(
			user_id: current_user.id,
			stage: params[:stage], 
			source: params[:source],
			timesreviewed: params[:timesreviewed].to_i,
			timessuccess: params[:timessuccess].to_i,
			timesfailed: params[:timesfailed].to_i,
		)

		if @card.save 
			puts "The card with source: " + @card.source + " was saved"

		else
			puts "The card was NOT saved"
		end
	end	

end