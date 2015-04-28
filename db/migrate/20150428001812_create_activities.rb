class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :activity_name
      t.string :position
      t.text :description
      t.integer :student_id
      t.date :start_date
      t.date :end_date
      t.timestamps null: false
    end
  end
end
