class PagesController < ApplicationController


	def index
	end 


	def create
		@company = Company.all
		if @company.where(company_key: params[:company_key]).exists?
			#session[:company_key] = params[:company_key]
			@response = "Your key has been verified!"
			respond_to do |format|
			    format.html { redirect_to new_user_registration_path }
			    format.js
			end
		else
			redirect_to root_path
			
		end
	end 
end
