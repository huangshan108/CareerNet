# == Schema Information
#
# Table name: projects
#
#  id           :integer          not null, primary key
#  project_name :string
#  description  :text
#  student_id   :integer
#  position     :string
#  start_date   :date
#  end_date     :date
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Project < ActiveRecord::Base
	belongs_to :student
end
