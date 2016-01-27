class Company < ActiveRecord::Base
	 attr_readonly :company_key
	 validates :name, presence: true, uniqueness: true
	 validates :company_key, presence: true, uniqueness: true
end
