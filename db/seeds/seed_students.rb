require 'time'
resume_link = 'http://www.grad.illinois.edu/careerservices/nonacademic/resumes/samples.pdf'
university = 'University of California, Berkeley'

random_dates_list = []
random_dates = File.open(File.join(Rails.root, 'db', 'seeds', 'db_seed_data/random_dates.txt')).read
random_dates.each_line do |line|
	random_dates_list << Date.parse(line)
end

random_majors_list = []
random_majors = File.open(File.join(Rails.root, 'db', 'seeds', 'db_seed_data/random_majors.txt')).read
random_majors.each_line do |line|
	random_majors_list << line.strip
end

random_dates = File.open(File.join(Rails.root, 'db', 'seeds', 'db_seed_data/random_dates.txt')).read
students = []
random_names = File.open(File.join(Rails.root, 'db', 'seeds', 'db_seed_data/random_names.txt')).read

random_names.each_line do |line|
	student = {}
	first_name, last_name = line.split()
	student[:first_name] = first_name
	student[:last_name] = last_name 
	student[:major] = random_majors_list.sample
	student[:graduation_date] = random_dates_list.sample
	student[:university] = university
	student[:resume_link] = resume_link
	students << student
end

students.each do |student|
	Student.create!(student)
end

puts "Done!"