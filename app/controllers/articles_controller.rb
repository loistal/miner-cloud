class ArticlesController < ApplicationController

	def create
		puts params[:article][:difficulty]
		@article = Article.new(difficulty: params[:difficulty], 
			user_id: current_user.id, 
			language: params[:language], 
			lesson:params[:article][:lesson], 
			title: params[:article][:title])

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

end