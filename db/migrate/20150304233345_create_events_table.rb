class CreateEventsTable < ActiveRecord::Migration
  def change
    create_table :events do |t|
    	t.string :title
      t.text :description
      t.time :time_start
      t.time :time_end
      t.string :location
      t.timestamps
    end
  end
end
