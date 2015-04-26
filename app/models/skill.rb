# == Schema Information
#
# Table name: skills
#
#  id   :integer          not null, primary key
#  name :string
#

class Skill < ActiveRecord::Base
	has_and_belongs_to_many :students
end
