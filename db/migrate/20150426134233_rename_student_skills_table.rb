class RenameStudentSkillsTable < ActiveRecord::Migration
  def change
  	rename_table :studentskills, :skills_students
  end
end
