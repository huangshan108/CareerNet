class Company < ActiveRecord::Base
	belongs_to :account
	has_many :jobs
	has_many :applications
	has_many :interviews
	has_many :students, :through => :applications

	def getInterviews(start_date, end_date, mineOnly)

	end

	def getEvents(start_date, end_date, mineOnly)

	end

	def getAppointments(start_date, end_date, mineOnly)

	end
end
