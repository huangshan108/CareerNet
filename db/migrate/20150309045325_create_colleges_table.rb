class CreateCollegesTable < ActiveRecord::Migration
  def change
    create_table :colleges do |t|
    	t.string :address
    	t.string :school_name
    	t.string :school_type
    	t.string :school_year
    end
  end
end
