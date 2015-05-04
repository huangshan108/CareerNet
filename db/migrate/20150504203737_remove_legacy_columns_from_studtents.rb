class RemoveLegacyColumnsFromStudtents < ActiveRecord::Migration
  def change
  	remove_column :students, :lastemployer
  	remove_column :students, :city
  	remove_column :students, :state
  	remove_column :students, :ethnicity
  	remove_column :students, :citizenship
  	remove_column :students, :years_experience
  	remove_column :students, :industry
  	remove_column :students, :base_salary
  	remove_column :students, :title
  	remove_column :students, :company_id
  end
end
