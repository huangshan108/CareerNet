Given /the following appointments exist/ do |appointments_table|
  appointments_table.hashes.each do |appt|
  new_appt = Appointment.create!(
    day: appt['day'],
  	time_slot: appt['time_slot'],
    student_id: appt['student_id'],
    staff_id: appt['staff_id']
  )
  end
end

