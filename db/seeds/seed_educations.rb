
puts "Seeding Educations..."

Student.all.count.times do |id|
    education = {}
    time = Faker::Time.between(3.years.ago, Time.now, :all)
    education[:school_name] = College.find(rand(1..14125)).school_name 
    education[:major] = Major.find(rand(1..1915)).name
    education[:student_id] = id
    education[:start_date] = time
    education[:graduation_date] = time + 4.years
    Education.create! education
end

puts "Done!"
