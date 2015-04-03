require 'will_paginate'

class Student < ActiveRecord::Base
	belongs_to :college
	belongs_to :major
	belongs_to :account

	has_many :applications
	has_many :jobs, :through => :applications
end
