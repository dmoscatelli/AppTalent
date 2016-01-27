module CompanyHelper
	
	def company
		@company = Company.all
	end 

	 def companies_count
	    if current_admin 
	      Company.count
	    end 
  	end

  	def survey_comp_active 
  		

  	end 

end
