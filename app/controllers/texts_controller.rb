class TextsController < ApplicationController

	def index
		if params[:difficulty] != nil && params[:language] != nil
			difficulty = params[:difficulty]
			language = params[:language]
		else 
			difficulty = 1
			language = "english"
		end

		@articles = Article.where(difficulty: difficulty, language: language)



		@message = "We currently don't have any <b>" + difficulty_to_string(difficulty) + "</b> articles in <b>" + language.capitalize + "</b>"
		if @articles.count > 0
			@message = "We found <b>" + @articles.count.to_s + " " + difficulty_to_string(difficulty) + "</b> articles in <b>" + language.capitalize + "</b>"
		end

	end

end