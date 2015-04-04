class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.belongs_to :staff, index: true
      t.belongs_to :student, index: true
      t.integer :time_slot
      t.date :day
      t.text :description
      t.text :note
      t.timestamps
    end
  end
end
