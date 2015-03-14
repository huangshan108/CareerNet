require 'will_paginate'

class Student < ActiveRecord::Base
	belongs_to :college
	belongs_to :major
	belongs_to :account
end
