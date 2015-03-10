require 'time'
description = 'Come meet employers and alumni from various roles and niches of the Environmental Sector. Some employers and alumni will be actively recruiting for positions, while others will be there to help students learn about the organizations and what they do with the field. This event is appropriate for students who are job/internship seeking (bring your resumes!) and also those who many just be starting to explore what is available in the environmental field.'

random_events = File.open(File.join(Rails.root, 'db', 'seeds', 'db_seed_data/random_events.txt')).read
random_events.each_line do |line|
	event = {}
	title, time, location = line.split("%")
	time_start, time_end = time.split("-")
	time_start = Time.parse(time_start)
	time_end = Time.parse(time_end)
	event[:title] = title
	event[:description] = description
	event[:time_start] = time_start
	event[:time_end] = time_end
	event[:location] = location
	Event.create!(event)
end

	

puts "Done!"