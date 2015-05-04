puts "Seeding Job Applcations..."
students_count = Student.count
jobs_count = Job.count

10000.times do
	Application.create({
		:student_id => rand(students_count),
		:job_id => rand(jobs_count)
	}) 
end

puts "Done!"

# puts "Seeding Registed Events..."
# student_accounts = Account.where(:account_type => 1)
# events_count = Event.count

# 10000.times do
# 	.create({
# 		:account_id => student_accounts.sample.id,
# 		:event_id => rand(events_count)
# 	})
# end

# puts "Done!"