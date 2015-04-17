class AddFieldsToCompany < ActiveRecord::Migration
  def change
  	add_column :companies, :city, :string
  	add_column :companies, :state, :string
  	add_column :companies, :country, :string
  	add_column :companies, :industry, :string
  end
end
