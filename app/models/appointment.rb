class Appointment < ActiveRecord::Base
    belongs_to :staff
    belongs_to :student
end
