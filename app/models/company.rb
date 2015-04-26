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
	has_many :jobs
	has_many :applications
	has_many :interviews
	has_many :students, :through => :applications

	def getInterviews(start_date, end_date)
		self.interviews.select{|i| 
			i.day >= start_date.to_date and i.day <= end_date.to_date
		}
	end

	def getEvents(start_date, end_date)
		self.account.events.select{ |e|
			e.time_start >= start_date.to_date and e.time_end <= end_date.to_date
		}
	end

	def getAppointments(start_date, end_date)
		[]
	end

end
