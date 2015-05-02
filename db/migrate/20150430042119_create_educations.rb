class CreateEducations < ActiveRecord::Migration
  def change
    create_table :educations do |t|
      t.string :school_name
      t.string :major
      t.integer :student_id
      t.date :start_date
      t.date :graduation_date
      t.timestamps null: false
    end
  end
end
