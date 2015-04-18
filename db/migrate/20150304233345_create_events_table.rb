class CreateEventsTable < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.datetime :time_start
      t.datetime :time_end
      t.string :location
      t.timestamps
    end
  end
end
