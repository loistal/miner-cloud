class ArticlesController < ApplicationController

	def create
		puts params[:article][:difficulty]
		@article = Article.new(difficulty: params[:difficulty], 
			user_id: current_user.id, 
			language: params[:language], 
			lesson:params[:article][:lesson], 
			title: params[:article][:title])

		if @article.save 
			redirect_to text_path
		else
			# do something
			redirect_to text_path
			puts @article.errors.full_messages
		end
	end

	private 

	def article_params 
		params.require(:article).permit(:title, :difficulty, :language, :lesson, :user)
	end

end