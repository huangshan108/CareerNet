class CreateEventsTable < ActiveRecord::Migration
  def change
    create_table :events_tables do |t|
    	t.string :title
      t.text :description
      t.datetime :datetime
      t.timestamps
    end
  end
end
