# == Schema Information
#
# Table name: colleges
#
#  id          :integer          not null, primary key
#  address     :string
#  school_name :string
#  school_type :string
#  school_year :string
#

class College < ActiveRecord::Base
	has_many :students
end
