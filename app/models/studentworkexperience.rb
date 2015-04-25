class Studentworkexperience < ActiveRecord::Base
	belongs_to :student
	belongs_to :workexperience
end
