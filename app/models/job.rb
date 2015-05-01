# == Schema Information
#
# Table name: jobs
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  salary      :string
#  created_at  :datetime
#  updated_at  :datetime
#  company_id  :integer
#

class Job < ActiveRecord::Base
    belongs_to :company
    has_many :applications
    has_many :students, :through => :applications
end
