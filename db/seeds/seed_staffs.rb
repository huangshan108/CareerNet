require 'time'
puts "Seeding Staffs..."

base_username = "careernet.staff"
random_dates_list = []
random_dates = File.open(File.join(Rails.root, 'db', 'seeds', 'db_seed_data/random_dates.txt')).read
random_dates.each_line do |line|
	random_dates_list << Date.parse(line)
end

random_names = File.open(File.join(Rails.root, 'db', 'seeds', 'db_seed_data/random_names_lite.txt')).read

random_names.each_line do |line|
	staff = {}
	first_name, last_name = line.split()
	staff[:first_name] = first_name
	staff[:last_name] = last_name 

	s = Staff.create! staff
	account = {}
	account[:name] = base_username + "." + s.id.to_s
	account[:email] = base_username + "+" + s.id.to_s + "@gmail.com"
	account[:account_type] = 2
	account[:password] = "careernet"
	a = Account.create! account
	s.update_attributes(:account_id => a.id)
	for i in 1..3
	  if random_dates_list.length > 0
	  	appointment = {}
	  	appointment[:staff_id] = s.id
	  	appointment[:time_slot] = i
	  	appointment[:day] = random_dates_list.pop
	  	Appointment.create! appointment
	  end
	end
end

puts "Done!"