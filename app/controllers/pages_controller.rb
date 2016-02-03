class PagesController < ApplicationController


	def index
	end 

	def privacy
	end 

	def register
	end 

	def help
	end 

	def about 
	end 


	def verify
		if session[:company_key] && current_user
			flash[:notice] = "You have already verified your company key." 
			redirect_to root_path
		elsif session[:company_key]
			flash[:notice] = "You have already verified your company key."
			redirect_to new_user_registration_path
		elsif current_user
			flash[:notice] = "You have already verified your company key."
			redirect_to root_path
		end 
	end 


	def create
		@company = Company.all
		
		respond_to do |format| 
		    format.html {
		      if @company.where(company_key: params[:company_key]).exists?
		      	session[:company_key] = params[:company_key]
		        redirect_to new_user_registration_path 
		      else
		        redirect_to root_path
		      end
		    }
		    format.js {
		      if @company.where(company_key: params[:company_key]).exists?
		     	session[:company_key] = params[:company_key]
				@verified = Company.find_by(company_key: params[:company_key]).name
				@key = Company.find_by(company_key: params[:company_key]).company_key
		      else
		        @verified = "No Company Found"
				@key = "None"
		      end
		    }
		  end
		end 
	end 







