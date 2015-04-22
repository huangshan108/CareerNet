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

	def getInterviews(start_date, end_date)
		[]
	end

	def getEvents(start_date, end_date)
		self.account.events.select{ |e|
			e.time_start >= start_date.to_date and e.time_end <= end_date.to_date
		}
	end

	def getAppointments(start_date, end_date)
		self.appointments.select{|a| 
			a.day >= start_date.to_date and a.day <= end_date.to_date
		}
	end

end
