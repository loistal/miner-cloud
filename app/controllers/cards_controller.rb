class CardsController < ApplicationController

	def index
		
	end

	# create a new card
	def create

		@existingCard = Card.where(user_id: current_user.id, source: params[:source])
		if(@existingCard.exists?)
			puts "The card already exists for the current user" 
		else
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

end