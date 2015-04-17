class Event < ActiveRecord::Base
    has_many :student
    has_many :staff
    has_many :company

	def as_json(options = {})
		{
            :title => title,
            :start => created_at,
            :end => created_at+3600,
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
