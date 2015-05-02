class AddClassOfColumnToStudentsTable < ActiveRecord::Migration
  def change
  	add_column :students, :class_of, :integer
  	Student.all.each do |s|
  		s.class_of = s.graduation_date.year
  		s.save!
  	end
  end
end
