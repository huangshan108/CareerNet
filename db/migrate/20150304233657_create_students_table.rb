class CreateStudentsTable < ActiveRecord::Migration
  def change
    create_table :students do |t|
    	t.string :first_name
      t.string :last_name
      t.integer :major_id
      t.date :graduation_date
      t.integer :college_id
      t.string :resume_link
      t.timestamps
    end
  end
end
