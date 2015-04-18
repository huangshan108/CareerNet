#create appointments table
Given /the following appointments exist/ do |appointment_table|
  appointment_table.hashes.each do |appointment|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    new_appointment = Appointment.create!(staff_id: appointment[:staff_id],  student_id: appointment[:student_id], time_slot: appointment[:time_slot], day: Time.now)
    new_appointment.save
  end
end