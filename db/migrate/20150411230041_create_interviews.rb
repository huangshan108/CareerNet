class CreateInterviews < ActiveRecord::Migration
  def change
    create_table :interviews do |t|
      t.belongs_to :company, index: true
      t.belongs_to :student, index: true
      t.belongs_to :application
      t.integer :time_slot
      t.date :day
      t.text :description
      t.text :note
      t.timestamps
    end
  end
end
