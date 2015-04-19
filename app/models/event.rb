# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  time_start  :datetime
#  time_end    :datetime
#  location    :string
#  created_at  :datetime
#  updated_at  :datetime
#

class Event < ActiveRecord::Base
    has_and_belongs_to_many :accounts

	def as_json(options = {})
		{
            :title => title,
            :time_start => time_start,
            :time_end => time_end,
            :allDay => false,
            :id => id,
            :url => Rails.application.routes.url_helpers.event_path(self),
            :color => 'LightBlue'
        }
	end

    def self.between(start_day, end_day)
      self.where("time_start >= ? AND time_end <= ?", start_day.to_date, end_day.to_date)
    end

end
