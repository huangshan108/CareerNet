class ChangeJobs < ActiveRecord::Migration
  def change
  	remove_column "jobs", "company"
  	add_column "jobs", "company_id", :integer
  end
end
