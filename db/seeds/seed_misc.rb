# puts "Seeding Job Applcations..."
# students_count = Student.count
# jobs_count = Job.count

# 10000.times do
# 	Application.create({
# 		:student_id => rand(students_count) + 1,
# 		:job_id => rand(jobs_count) + 1
# 	}) 
# end

# puts "Done!"

puts "Seeding Registed Events..."
accounts_count = Account.count
events_count = Event.count

10000.times do
  event = Event.find(rand(events_count) + 1)
  user = Account.find(rand(accounts_count) + 1)
  event.accounts << user
end

puts "Done!"