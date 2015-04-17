# == Schema Information
#
# Table name: companies
#
#  id         :integer          not null, primary key
#  name       :string
#  website    :string
#  address    :string
#  account_id :integer
#  brief      :text
#  created_at :datetime
#  updated_at :datetime
#

class Company < ActiveRecord::Base
	belongs_to :account
	has_many :jobs
end
