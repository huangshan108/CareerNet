require 'time'
puts "Seeding Students..."

resume_link = 'http://www.grad.illinois.edu/careerservices/nonacademic/resumes/samples.pdf'
university = 'University of California, Berkeley'
base_username = "careernet.student"
random_dates_list = []
random_dates = File.open(File.join(Rails.root, 'db', 'seeds', 'db_seed_data/random_dates.txt')).read
random_dates.each_line do |line|
	random_dates_list << Date.parse(line)
end

random_names = File.open(File.join(Rails.root, 'db', 'seeds', 'db_seed_data/random_names.txt')).read

random_names.each_line do |line|
	student = {}
	first_name, last_name = line.split()
	student[:first_name] = first_name
	student[:last_name] = last_name 
	student[:major_id] = 1 + rand(1000)
	student[:graduation_date] = random_dates_list.sample
	student[:college_id] = 1 + rand(10000)
	student[:resume_link] = resume_link
	s = Student.create! student
	account = {}
	account[:name] = base_username + "." + s.id.to_s
	account[:email] = base_username + "+" + s.id.to_s + "@gmail.com"
	account[:account_type] = 1
	account[:password] = "careernet"
	a = Account.create! account
	s.update_attributes(:account_id => a.id)
end



puts "Done!"