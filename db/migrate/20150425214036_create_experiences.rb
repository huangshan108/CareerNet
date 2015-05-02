class CreateExperiences < ActiveRecord::Migration
  def change
    create_table :experiences do |t|
      t.belongs_to :student, index: true
      t.string :org_name
      t.string :job_title
      t.string :industry
      t.integer :yr_exp
      t.integer :salary
      t.string :city
      t.string :state
      t.string :country

      t.timestamps null: false
    end
  end
end
