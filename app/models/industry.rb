# == Schema Information
#
# Table name: industries
#
#  id         :integer          not null, primary key
#  industry   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Industry < ActiveRecord::Base
	has_many :students
end
