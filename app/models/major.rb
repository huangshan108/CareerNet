# == Schema Information
#
# Table name: majors
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime
#  updated_at :datetime
#

class Major < ActiveRecord::Base
    has_many :students
end
