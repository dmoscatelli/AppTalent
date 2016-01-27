class PagesController < ApplicationController


	def index
	end 

	def create
		@company = Company.all
		if @company.where(company_key: params[:company_key]).exists?
			redirect_to new_user_registration_path
			flash[:notice] = "Verified!"
		else
			redirect_to root_path
			flash[:notice] = "Incorrect key"
		end 
	end
	
end
