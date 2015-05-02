class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :project_name
      t.text :description
      t.integer :student_id
      t.string :position
      t.date :start_date
      t.date :end_date
      t.timestamps null: false
    end
  end
end
