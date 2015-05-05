# == Schema Information
#
# Table name: activities
#
#  id            :integer          not null, primary key
#  activity_name :string
#  position      :string
#  description   :text
#  student_id    :integer
#  start_date    :date
#  end_date      :date
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Activity < ActiveRecord::Base
	belongs_to :student
end
