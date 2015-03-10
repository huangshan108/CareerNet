class Student < ActiveRecord::Base
	belongs_to :college
	belongs_to :major
end
