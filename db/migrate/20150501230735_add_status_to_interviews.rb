class AddStatusToInterviews < ActiveRecord::Migration
  def change
    add_column :interviews, :status, :string
  end
end
