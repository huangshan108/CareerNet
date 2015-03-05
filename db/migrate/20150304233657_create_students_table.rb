class CreateStudentsTable < ActiveRecord::Migration
  def change
    create_table :students do |t|
    	t.string :first_name
      t.string :last_name
      t.string :major
      t.date :graduation_date
      t.string :university
      t.string :resume_link
      t.timestamps
    end
  end
end
