# == Schema Information
#
# Table name: studentskills
#
#  id         :integer          not null, primary key
#  student_id :integer
#  skill_id   :integer
#

class Studentskill < ActiveRecord::Base
	belongs_to :student
	belongs_to :skill
end
