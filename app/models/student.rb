require 'will_paginate'

class Student < ActiveRecord::Base
	belongs_to :college
	belongs_to :major
	belongs_to :account
	belongs_to :company

	has_many :appointments
	has_many :staffs, :through => :appointments

	has_many :applications
	has_many :jobs, :through => :applications
	
	has_many :interviews
	has_many :companies, :through => :interviews
	  
	has_many :studentskills
	has_many :skills, through: :studentskills

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
		self.appointments.select{|a| 
			a.day >= start_date.to_date and a.day <= end_date.to_date
		}
	end

end
