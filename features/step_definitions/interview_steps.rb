Given /the following interviews exist/ do |interviews_table|
  interviews_table.hashes.each do |interview|
  new_interview = Interview.create!(
    day: interview['day'],
  	time_slot: interview['time_slot'],
    application_id: interview['application_id'],
    student_id: interview['student_id'],
    company_id: interview['company_id']
  )
  end
end

Then /^I enter event title "(.+)" into "(.+)"$/ do |value, field|
  enter_stuff value, field
end


When /^I wait until "([^"]*)" is visible$/ do |selector|
  page.has_link?("#{selector}", :visible => true)
end
