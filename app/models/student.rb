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
			i.day >= start_date.to_date and i.day <= end_date.to_date
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

    # Counts the number of case of interest from returned array of Students
    def self.student_array_count(student_array)
        male = 0
        female = 0
        us = 0
        student_array.each do |student|
            if student[:gender] == "M"
                male += 1
            elsif student[:gender] == "F"
                female += 1
            end
            if student[:country] == "US"
                us += 1
            end
        end
        { male_count: male, female_count: female, us_count: us }
    end

    def self.student_demographic_json(countries, genders, classes)
        #Active Relations of students fitting requirements
        interest_students = Student.where(country: countries, gender: genders).select { |m| classes.include? m.graduation_date.year.to_s }

        # Breakdown of students of interest
        num_students = interest_students.size

        student_count = self.student_array_count(interest_students)
        f_students = student_count[:female_count]
        m_students = student_count[:male_count]
        us_students = student_count[:us_count]

        ratio_big_enough = num_students * 0.2
        majors = Major.joins(:students).includes(:students).group('major_id').having('COUNT(*) >= ?', ratio_big_enough)

        # Country json Prep
        country_count = [
            {name: "U.S.", count: us_students},
            {name: "International", count: num_students - us_students}
        ]

        # Gender json Prep
        gender_count = [
            {name: "Male", count: m_students},
            {name: "Female", count: f_students},
            {name: "Others", count: num_students - m_students - f_students}
        ]

        # Major json Prep
        major_count = []
        majors.each do |major|
            student_count = Student.where(major_id: major.id).count
            major_count = major_count + [{name: major.name, count: student_count}]
        end

        # Class json Prep
        class_count = []
        classes.each do |year|
            student_count = Student.class_of(year).count
            class_count = class_count + [{ name: "Class of " + year, count: student_count }]
        end


        #json
        {
            countries: country_count,
            genders: gender_count,
            majors: major_count,
            classes: class_count
        }
    end

    scope :class_of, lambda { |year| where("graduation_date >= ? and graduation_date <= ?", "#{year}-01-01", "#{year}-12-31") }

end
