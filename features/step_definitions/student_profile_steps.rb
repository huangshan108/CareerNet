Given /the following students exist/ do |students_table|
  students_table.hashes.each do |student|
    new_student = Student.create!({
      first_name: student[:first_name], 
      last_name: student[:last_name],  
      college_id: student[:college_id], 
      major_id: student[:major_id],
      account_id: student[:account_id],
      resume_link: student[:resume_link]
      })
  end
end

Given /the following schools exist/ do |schools_table|
  schools_table.hashes.each do |school|
    new_school = College.create!(school_name: school[:school_name], school_type: school[:school_type],  school_year: school[:school_year], address: school[:address])
  end
end

Given /the following majors exist/ do |majors_table|
  majors_table.hashes.each do |major|
    new_major = Major.create!(name: major[:name])
  end
end

Given /the following skills exist/ do |skills_table|
  skills_table.hashes.each do |skill|
    new_skill = Skill.create!(name: skill[:name])
    new_skill.save
  end
end

When(/^I fill in First Name with "(.*?)"$/) do |arg1|
  fill_in "first_name", :with => arg1
end

When /^I try to edit view student C profile page$/ do
    visit "/profiles/student/101/edit"
end

When /^I try visit student C application page$/ do
    visit "applications/student/101"
end

When /^I try visit random company application page$/ do
    visit "applications/company/101"
end