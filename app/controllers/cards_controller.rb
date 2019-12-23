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
			@nextCard.due_on = Time.now + 2.days
		when 3
			@nextCard.due_on = Time.now + 4.days
		when 4
			@nextCard.due_on = Time.now + 1.weeks
		when 5
			@nextCard.due_on = Time.now + 2.weeks
		when 6
			@nextCard.due_on = Time.now + 1.months
		when 7
			@nextCard.due_on = Time.now + 2.months
		when 8
			@nextCard.due_on = Time.now + 4.months
		when 9
			@nextCard.due_on = Time.now + 8.months # card is mastered
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

		# return the next card to be displayed
		render json: get_next_card()
	end

	def reschedule_again
		@nextCard = get_next_card()

		if(@nextCard.stage == nil) 
			@nextCard.stage = 1
		end

		# no matter what stage the card is in, it should be reveiewed the following day
		@nextCard.due_on = Time.now + 1.days

		if(@nextCard.stage != 1) 
			# we go back 1 stage upon failing the card
			@nextCard.stage -= 1
		end


		@nextCard.timesreviewed += 1
		@nextCard.timesfailed += 1

		@nextCard.save

		# return the next card to be displayed
		render json: get_next_card()
	end

	def set_mastered
		@nextCard = get_next_card()

		# stage 10 is mastery
		@nextCard.stage = 10
		@nextCard.timesreviewed += 1
		@nextCard.timessuccess += 1
		@nextCard.save

		# return the next card to be displayed
		render json: get_next_card()
	end

	def delete_card
		@nextCard = get_next_card()
		@nextCard.destroy

		# return the next card to be displayed
		render json: get_next_card()
	end

	private 

	def get_next_card
		return Card.where("due_on <= ? AND stage != 10 AND user_id = " + current_user.id.to_s, Time.current).first
	end

end