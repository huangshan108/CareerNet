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
#  city       :string
#  state      :string
#  country    :string
#  industry   :string
#


class Company < ActiveRecord::Base
	belongs_to :account
    belongs_to :experience
	has_many :jobs
	has_many :applications
	has_many :interviews
	has_many :students, :foreign_key => :company_id, :class_name => "Experience"

  def self.get_company_vis_data(countries, genders, classes)
		response = GeneralStats.get_vis_data("Company", countries, genders, classes)
		# possible pre processing before return
		return response
  end
end
