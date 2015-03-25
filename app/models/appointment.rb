class Appointment < ActiveRecord::Base
    belongs_to :staff
    belongs_to :student

    def self.appointments_this_week(user)
        self.where("day >= ?", Date.today.at_beginning_of_week)
    end

    def self.appointments_weeks_ago(user, weeks_ago)
        self.where("day >= ?", Date.today.at_beginning_of_week.days_ago(7 * weeks_ago))
    end
end
