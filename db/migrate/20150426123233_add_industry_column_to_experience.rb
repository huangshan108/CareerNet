class AddIndustryColumnToExperience < ActiveRecord::Migration
  def change
  	remove_column :experiences, :industry
  	add_column :experiences, :industry_id, :integer
  end
end
