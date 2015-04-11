class AddCountryAndGenderToStudents < ActiveRecord::Migration
  def change
    add_column :students, :country, :string
    add_column :students, :gender, :string
  end
end
