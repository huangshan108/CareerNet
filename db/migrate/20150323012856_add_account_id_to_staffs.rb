class AddAccountIdToStaffs < ActiveRecord::Migration
  def change
    add_column :staffs, :account_id, :integer
  end
end
