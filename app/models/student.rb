require 'will_paginate'

class Student < ActiveRecord::Base
	belongs_to :college
	belongs_to :major
	belongs_to :account

  has_many :appointments
  has_many :staffs, :through => :appointments

	has_many :applications
	has_many :jobs, :through => :applications
	
  has_many :interviews
  has_many :companies, :through => :interviews
  

  has_many :studentskills
	has_many :skills, through: :studentskills
end
