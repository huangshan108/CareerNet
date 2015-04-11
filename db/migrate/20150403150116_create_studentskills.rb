class CreateStudentskills < ActiveRecord::Migration
  def change
    create_table :studentskills do |t|
    	t.integer :student_id
    	t.integer :skill_id
    end
  end
end
