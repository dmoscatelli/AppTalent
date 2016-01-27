class AddCompanyIdAndKeyToSurveys < ActiveRecord::Migration
  def change
  		add_column :survey_surveys, :company_key, :string
  		add_reference :companies, :company, index:true
  end
end
