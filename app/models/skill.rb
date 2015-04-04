class Skill < ActiveRecord::Base
	has_many :studentskills
	has_many :students, through: :studentskills
end