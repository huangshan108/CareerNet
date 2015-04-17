# == Schema Information
#
# Table name: skills
#
#  id   :integer          not null, primary key
#  name :string
#

class Skill < ActiveRecord::Base
	has_many :studentskills
	has_many :students, through: :studentskills
end
