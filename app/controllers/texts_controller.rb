class TextsController < ApplicationController

	def index
		@articles = Article.all
	end

end