class CompaniesController < ApplicationController
	before_filter :authenticate_admin!
	before_action :find_company, only: [:edit, :update, :show, :destroy]

	def index
		@company = Company.all
	end

	def show
	end


	def new
		@company = Company.new
	end

	def create
		@company = Company.new(company_params)

		if @company.save
			redirect_to @company
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @company.update(company_params)
			redirect_to @company
		else
			render 'edit'
		end 
	end

	def destroy
		@survey = Survey::Survey.all
		@survey_name = @survey.where(company_key: @company.company_key).name
		if @survey.where(company_key: @company.company_key).exists?
			flash[:notice] = "You cannot delete this company. It belongs to current active surveys"
			redirect_to companies_path
		else
			@company.destroy
			redirect_to companies_path
		end
	end  


	private




	def find_company
		@company = Company.find(params[:id])
	end 

	def company_params
		params.require(:company).permit(:name, :company_key)
	end 



end
