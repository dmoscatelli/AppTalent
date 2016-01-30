class PagesController < ApplicationController


	def index
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







