class Staff < ActiveRecord::Base
    has_many :appointments
    has_many :students, :through => :appointments
    belongs_to :account
	has_many :events

	def getInterviews(start_date, end_date)
		[]
	end

	def getEvents(start_date, end_date)
		# self.events.select{ |e|
		# 	e.time_start >= start_date.to_date and e.time_end <= end_date.to_date
		# }

		# Event registration is not ready yet
		[]
	end

	def getAppointments(start_date, end_date)
		self.appointments.select{|a| 
			a.day >= start_date.to_date and a.day <= end_date.to_date
		}
	end

end
