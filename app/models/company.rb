class Company < ActiveRecord::Base
	belongs_to :account
	has_many :jobs
	has_many :applications
	has_many :interviews
	has_many :students, :through => :applications
	has_many :events

	def getInterviews(start_date, end_date)
		self.interviews.select{|i| 
			Interview.timeslot_to_string(i.time_slot).to_date >= start_date.to_date and 
			Interview.timeslot_to_string(i.time_slot+1).to_date <= end_date.to_date
		}
	end

	def getEvents(start_date, end_date)
		self.events.select{ |e|
			e.time_start >= start_date.to_date and e.time_end <= end_date.to_date
		}
	end

	def getAppointments(start_date, end_date)
		[]
	end

end
