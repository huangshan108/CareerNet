# == Schema Information
#
# Table name: interviews
#
#  id             :integer          not null, primary key
#  company_id     :integer
#  student_id     :integer
#  application_id :integer
#  time_slot      :integer
#  day            :date
#  description    :text
#  note           :text
#  created_at     :datetime
#  updated_at     :datetime
#

class Interview < ActiveRecord::Base
    belongs_to :company
    belongs_to :student
    belongs_to :application

    def as_json(options = {})

        title = self.student == nil ? "Empty" : self.student.last_name
        #time_slot 1 -> 10 a.m.
        # 20 minute increment until 4p.m.
        # min 0, max 18
        start_datetime = self.day.to_s + " " + Appointment.timeslot_to_string(self.time_slot)
        end_datetime = self.day.to_s + " " + Appointment.timeslot_to_string(self.time_slot + 1)
        {:title => title, :start => start_datetime, :end => end_datetime, :allDay => false, :id => id, :color => 'blue', :detailURL => Rails.application.routes.url_helpers.interview_student_show_path}
    end

    def self.between(start_day, end_day)
      self.where("day >= ? AND day <= ?", start_day.to_date, end_day.to_date)
    end
end
