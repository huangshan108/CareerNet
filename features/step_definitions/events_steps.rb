Given /the following events exist/ do |events_table|
  events_table.hashes.each do |event|
  new_event = Event.create!(
  	title: event['title'], 
  	description: event['description'], 
  	time_start: event['time_start'], 
  	time_end: event['time_end'], 
  	location: event['location']
  )
  end
end

Then /^I enter event title "(.+)" into "(.+)"$/ do |value, field|
  enter_stuff value, field
end
