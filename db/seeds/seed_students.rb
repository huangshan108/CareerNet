require 'time'
resume_link = 'http://www.grad.illinois.edu/careerservices/nonacademic/resumes/samples.pdf'
university = 'University of California, Berkeley'

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
	student[:major_id] = 1 + rand(1962)
	student[:graduation_date] = random_dates_list.sample
	student[:college_id] = 1 + rand(14753)
	student[:resume_link] = resume_link
	Student.create!(student)
end



puts "Done!"