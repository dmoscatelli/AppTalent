class AnswersController < ApplicationController


	def index 
		@answers = Survey::Answer.all
	end 
end
