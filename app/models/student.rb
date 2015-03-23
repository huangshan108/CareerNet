require 'will_paginate'

class Student < ActiveRecord::Base
	belongs_to :college
	belongs_to :major
	belongs_to :account
    has_many :appointments
    has_many :staffs, :through => :appointments
end
