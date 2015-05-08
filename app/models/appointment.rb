# == Schema Information
#
# Table name: appointments
#
#  id          :integer          not null, primary key
#  staff_id    :integer
#  student_id  :integer
#  time_slot   :integer
#  day         :date
#  reason      :string
#  description :text
#  note        :text
#  created_at  :datetime
#  updated_at  :datetime
#

class Appointment < ActiveRecord::Base
    belongs_to :staff
    belongs_to :student

    def as_json(options = {})
        title = self.student == nil ? "Empty" : self.student.last_name
        # time_slot 1 -> 10 a.m.
        # 20 minute increment until 4p.m.
        # min 0, max 18
        start_datetime = self.day.to_s + " " + Appointment.timeslot_to_string(self.time_slot)
        end_datetime = self.day.to_s + " " + Appointment.timeslot_to_string(self.time_slot + 1)
        { :title => title, :start => start_datetime, :end => end_datetime, :allDay => false, :id => id, :detailURL => Rails.application.routes.url_helpers.appointments_path }
    end

    def self.new_in_row(start, ending, staff)
      timeslot = Appointment.string_to_timeslot(start)
      endslot = Appointment.string_to_timeslot(ending)
      error = false
      while timeslot < endslot do
        appt_params = { day: start, time_slot: timeslot, staff: staff}
        appt = Appointment.new(appt_params)
        timeslot += 1
        error = appt.save and error
      end
      [appt, error]
    end


    def self.timeslot_to_string(time_slot)
        hour = (time_slot - 1) / 3 + 10 
        min = (time_slot - 1)  % 3 * 20
        time = hour.to_s.rjust(2, "0") + ":" + min.to_s.rjust(2, "0") + ":00"
        time
    end

    def self.string_to_timeslot(time_string)
        match = /.*(\d\d):(\d\d):(\d\d)/.match(time_string)
        if match
            hour = match[1].to_i - 10
            min = match[2].to_i / 20
            if hour >= 0 and hour < 7
                hour * 3 + min + 1
            else
                0
            end
        else
            0
        end
    end

    def self.between(start_day, end_day)
      self.where("day >= ? AND day <= ?", start_day.to_date, end_day.to_date)
    end
end
