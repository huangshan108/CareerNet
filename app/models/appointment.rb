class Appointment < ActiveRecord::Base
    belongs_to :staff
    belongs_to :student

    def as_json(options = {})

        title = self.student == nil ? "Empty" : self.student.last_name
        #time_slot 1 -> 10 a.m.
        # 20 minute increment until 4p.m.
        # min 0, max 18
        start_datetime = self.day.to_s + "T" + self.timeslot_to_string(self.time_slot)
        end_datetime = self.day.to_s + "T" + self.timeslot_to_string(self.time_slot + 1)
        {
            :title => title,
            :start => start_datetime,
            :end => end_datetime
        }
    end

    def self.timeslot_to_string(time_slot)
        hour = time_slot / 3 + 10 
        min = time_slot % 3 * 20
        time = hour.to_s + ":" + min.to_s + ":00"
        time
    end

    def self.appointments_this_week(user)
        self.where("day >= ?", Date.today.at_beginning_of_week)
    end

    def self.appointments_weeks_ago(user, weeks_ago)
        self.where("day >= ? AND day < ?", 
                   Date.today.at_beginning_of_week.days_ago(7 * weeks_ago),
                   Date.today.at_beginning_of_week.days_ago(7 * (weeks_ago-1)))
    end
end
