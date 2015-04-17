class AdAddMoreFieldsToStudents < ActiveRecord::Migration
  def change
  	add_column :students, :ethnicity, :string
  	add_column :students, :citizenship, :string
  	add_column :students, :years_experience, :integer
  	add_column :students, :industry, :integer
  	add_column :students, :base_salary, :integer
  	add_column :students, :title, :string
  end
end
