module RegistrationsControllerHelper

	def read_test
		if session[:company_key]
			"true"
		else
			"false"
		end
	end


	def company_name 
		if session[:company_key]	
			Company.find_by(company_key: session[:company_key]).name
		end 
	end  

	def create
		session.delete(:company_key)
	end 

end
