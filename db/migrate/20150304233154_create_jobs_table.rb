class CreateJobsTable < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :title
      t.text :description
      t.string :company
      t.string :salary
      t.timestamps
    end
  end
end
