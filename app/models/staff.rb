class Staff < ActiveRecord::Base
    has_many :appointments
    has_many :students, :through => :appointments
    belongs_to :account

	def getInterviews(start_date, end_date, mineOnly)

	end

	def getEvents(start_date, end_date, mineOnly)

	end

	def getAppointments(start_date, end_date, mineOnly)

	end

end
