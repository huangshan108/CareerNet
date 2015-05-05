require 'date'

puts "Seeding Job Applcations..."
students_count = Student.count
jobs_count = Job.count

10000.times do
	Application.create({
		:student_id => rand(students_count) + 1,
		:job_id => rand(jobs_count) + 1
	}) 
end

puts "Done!"

puts "Seeding Registed Events..."
accounts_count = Account.count
events_count = Event.count

10000.times do
  event = Event.find(rand(events_count) + 1)
  user = Account.find(rand(accounts_count) + 1)
  event.accounts << user
end

puts "Done!"


puts "Seeding Interviews..."

def time_rand from = Time.now, to = Time.now + 2000000
  Time.at(from + rand * (to.to_f - from.to_f))
end

applications_count = Application.count

Application.all.each do |application|
	t = time_rand
	Interview.create({
		:student_id => application.student_id,
		:company_id => application.job.company_id,
		:application_id => application.id,
		:time_slot => rand(10),
		:day => "#{t.year}-#{t.month}-#{t.day}",
		:description => "As a result of your application for the position of Account Analyst, I would like to invite you to attend an interview at our office in Quincy, MA. You will have an interview with the department manager, Edie Wilson. The interview will last about 45 minutes. Please bring three references as well as a copy of your driver's license to the interview."
	})
end

puts "Done!"


puts "Seeding Student Skills..."

applications_count = Application.count

Student.all.each do |student|
	(rand(5) + 3).times do
		student.skills << Skill.find(rand(15) + 1)
	end
end

puts "Done!"