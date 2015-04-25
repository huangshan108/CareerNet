class CreateWorkexperiences < ActiveRecord::Migration
  def change
    create_table :workexperiences do |t|
    	t.string :company_name
    	t.string :location
    	t.string :job
    	t.integer :salary
    	t.integer :student_id
    	t.text :description
		t.timestamps null: false
    end
  end
end
