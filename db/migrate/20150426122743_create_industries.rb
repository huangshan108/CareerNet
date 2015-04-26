class CreateIndustries < ActiveRecord::Migration
  def change
    create_table :industries do |t|
    	t.string :industry
      t.timestamps null: false
    end
  end
end
