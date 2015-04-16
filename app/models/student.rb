require 'will_paginate'

class Student < ActiveRecord::Base
	belongs_to :college
	belongs_to :major
	belongs_to :account

  	has_many :appointments
  	has_many :staffs, :through => :appointments

	has_many :applications
	has_many :jobs, :through => :applications
	has_many :studentskills
	has_many :skills, through: :studentskills

	# def getInterviews(start_date, end_date, mineOnly)
	# 	if mineOnly
	# 		return self.interviews.select{|x| x.start_time >= start_time and x.end_time <= end_date}
	# 	else
	# end

	def getEvents(start_date, end_date, mineOnly)
		if mineOnly
			return self.events.select{|x| x.time_start >= start_time and x.time_end <= end_date}
		else
	end

	def getAppointments(start_date, end_date, mineOnly)

	end

end
