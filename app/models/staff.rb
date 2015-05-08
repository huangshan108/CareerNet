# == Schema Information
#
# Table name: staffs
#
#  id          :integer          not null, primary key
#  account_id  :integer
#  first_name  :string
#  last_name   :string
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

class Staff < ActiveRecord::Base
    has_many :appointments
    has_many :students, :through => :appointments
    belongs_to :account

end
