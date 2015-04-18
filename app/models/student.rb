# == Schema Information
#
# Table name: students
#
#  id              :integer          not null, primary key
#  major_id        :integer
#  first_name      :string
#  last_name       :string
#  graduation_date :date
#  college_id      :integer
#  resume_link     :string
#  created_at      :datetime
#  updated_at      :datetime
#  account_id      :integer
#  country         :string
#  gender          :string
#

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


	def getInterviews(start_date, end_date)
		self.interviews.select{|i| 
			i.day >= start_date.to_date and i.day <= end_date.to_date
		}
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
