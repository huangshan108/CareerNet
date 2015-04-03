class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
    	t.references :student
    	t.references :job
    	t.timestamps
    end
  end
end
