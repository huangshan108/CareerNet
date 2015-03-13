class AddAccountIdToStudents < ActiveRecord::Migration
  def change
  	add_column :students, :account_id, :integer
  end
end
