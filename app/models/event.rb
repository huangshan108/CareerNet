class Event < ActiveRecord::Base
    has_many :students
    has_many :staffs
    has_many :companies

	def as_json(options = {})
		{
            :title => title,
            :start => time_start,
            :end => time_end,
            :allDay => false,
            :id => id,
            :url => event_path(self),
            :color => '#009999'
        }
	end

    def self.between(start_day, end_day)
      self.where("date_start >= ? AND date_end <= ?", start_day.to_date, end_day.to_date)
    end

end
