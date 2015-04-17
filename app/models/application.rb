# == Schema Information
#
# Table name: applications
#
#  id         :integer          not null, primary key
#  student_id :integer
#  job_id     :integer
#  created_at :datetime
#  updated_at :datetime
#

class Application < ActiveRecord::Base
	belongs_to :student
	belongs_to :job
  has_many :interviews
end
