class AddCompanyKeyToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :company_key, :string
  end
end
