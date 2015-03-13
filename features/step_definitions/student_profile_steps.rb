Given /the following students exist/ do |students_table|
  students_table.hashes.each do |student|
    new_student = Student.create!(first_name: student[:first_name], last_name: student[:last_name],  college_id: student[:college_id], major_id: student[:major_id], resume_link: student[:resume_link])
    new_student.save
  end
end

Given /the following schools exist/ do |schools_table|
  schools_table.hashes.each do |school|
    new_school = College.create!(school_name: school[:school_name], school_type: school[:school_type],  school_year: school[:school_year], address: school[:address])
    new_school.save
  end
end

Given /the following majors exist/ do |majors_table|
  majors_table.hashes.each do |major|
    new_major = Major.create!(name: major[:name])
    new_major.save
  end
end

Then(/^I should see the student "(.*?)"$/) do |arg1|
  true
end

When(/^I fill in First Name with "(.*?)"$/) do |arg1|
  true
end

Then(/^I should see the school "(.*?)"$/) do |arg1|
  true
end