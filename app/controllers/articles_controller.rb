class ArticlesController < ApplicationController

	def create
		puts params[:article][:difficulty]

		@article = Article.new(difficulty: params[:difficulty], 
			user_id: current_user.id, 
			language: params[:language], 
			lesson: params[:article][:lesson], 
			title: params[:article][:title],
			icon: generate_random_icon())


		if @article.save 
			redirect_to controller: 'articles', action: "show", id: @article.id

		else
			# do something
			redirect_to text_path
			puts @article.errors.full_messages
		end
	end

	# show and individual article
	def show 
		@article = Article.find(params[:id])
	end

	private 

	def article_params 
		params.require(:article).permit(:title, :difficulty, :language, :lesson, :user)
	end

	def generate_random_icon

		@icon = "🍏"
		@randNum = rand(30)

		case @randNum
		when 0
			@icon = "🍎"
		when 1
			@icon = "🍐"
		when 2
			@icon = "🍊"
		when 3
			@icon = "🍋"
		when 4
			@icon = "🍌"
		when 5
			@icon = "🍉"
		when 6
			@icon = "🍇"
		when 7
			@icon = "🍓"
		when 8
			@icon = "🍈"
		when 9
			@icon = "🍒"
		when 10
			@icon = "🍑"
		when 11
			@icon = "🍍"
		when 12
			@icon = "🥥"
		when 13
			@icon = "🥝"
		when 14
			@icon = "🧁"
		when 15
			@icon = "🍰"
		when 16
			@icon = "🍭"
		when 17
			@icon = "🍿"
		when 18
			@icon = "🍩"
		when 19
			@icon = "🍪"
		when 20
			@icon = "🥞"
		when 21
			@icon = "🍕"
		when 22
			@icon = "🍙"
		when 23
			@icon = "🥟"
		when 24
			@icon = "🍱"
		when 25
			@icon = "🥮"
		when 26
			@icon = "🥯"
		when 27
			@icon = "🍦"
		when 28
			@icon = "🥧"
		when 29
			@icon = "☕️"
		else
			"Error"
		end
	end

end