class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
    	t.string :name
    	t.string :website
    	t.string :address
    	t.integer :account_id
    	t.text :brief
      t.timestamps
    end
  end
end
