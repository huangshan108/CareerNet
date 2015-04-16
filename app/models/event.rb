class Event < ActiveRecord::Base
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
end
