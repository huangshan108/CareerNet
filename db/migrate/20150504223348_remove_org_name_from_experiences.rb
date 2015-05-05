class RemoveOrgNameFromExperiences < ActiveRecord::Migration
  def change
  	remove_column :experiences, :org_name
  end
end
