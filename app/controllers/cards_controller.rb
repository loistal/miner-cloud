class CardsController < ApplicationController

	def index
		# the next
		@nextCard = get_next_card()

	end

	# create a new card
	def create

		@existingCard = Card.where(user_id: current_user.id, source: params[:source])
		if(@existingCard.exists?)
			puts "The card already exists for the current user" 
		else
			@card = Card.new(
				user_id: current_user.id,
				due_on: Time.now,
				stage: params[:stage], 
				source: params[:source],
				translation: params[:translation],
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

	def reschedule_good
		@nextCard = get_next_card()

		if(@nextCard.stage == nil) 
			@nextCard.stage = 1
		end

		# change the due date depending on the current stage
		case @nextCard.stage
		when 1
			@nextCard.due_on = Time.now + 1.days
		when 2
			@nextCard.due_on = Date.now + 2.days
		when 3
			@nextCard.due_on = Date.now + 4.days
		when 4
			@nextCard.due_on = Date.now + 1.weeks
		when 5
			@nextCard.due_on = Date.now + 2.weeks
		when 6
			@nextCard.due_on = Date.now + 1.months
		when 7
			@nextCard.due_on = Date.now + 2.months
		when 8
			@nextCard.due_on = Date.now + 4.months
		when 9
			@nextCard.due_on = Date.now + 8.months # card is mastered
		else
			puts "Stage not recognized"
		end

		if(@nextCard.stage != nil) 
			@nextCard.stage += 1
		else
			@nextCard.stage = 2
		end

		@nextCard.timesreviewed += 1
		@nextCard.timessuccess += 1

		@nextCard.save
	end


	private 

	def get_next_card
		return Card.where("due_on <= ? AND user_id = " + current_user.id.to_s, Time.current).first
	end

end