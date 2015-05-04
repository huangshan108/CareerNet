# == Schema Information
#
# Table name: workexperiences
#
#  id           :integer          not null, primary key
#  company_name :string
#  location     :string
#  job          :string
#  salary       :integer
#  student_id   :integer
#  description  :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Workexperience < ActiveRecord::Base
	belongs_to :student
end
