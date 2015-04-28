# == Schema Information
#
# Table name: industries
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Industry < ActiveRecord::Base
  has_many :students, :class_name => "Experience"

  def self.get_industry_vis_data(params)
  	response = GeneralStats.get_vis_data("Industry", params)
  	# possible pre processing before return
  	return response
  end
end
