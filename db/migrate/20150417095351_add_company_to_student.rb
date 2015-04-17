class AddCompanyToStudent < ActiveRecord::Migration
  def change
  	add_column :students, :company_id, :integer
  end
end
