# == Schema Information
#
# Table name: educations
#
#  id              :integer          not null, primary key
#  school_name     :string
#  major           :string
#  student_id      :integer
#  start_date      :date
#  graduation_date :date
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Education < ActiveRecord::Base
	belongs_to :student
end
