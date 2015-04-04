class CreateStaffs < ActiveRecord::Migration
  def change
    create_table :staffs do |t|
      t.belongs_to :account, index: true
      t.string :first_name
      t.string :last_name
      t.text :description
      t.timestamps
    end
  end
end
