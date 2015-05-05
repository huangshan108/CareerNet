
puts "Seeding Projects..."

Student.all.count.times do |id|
    rand(1..3).times do |i|
        project = {}
        proj_name = Faker::Hacker.verb.capitalize + " " + Faker::Hacker.adjective + " " + Faker::Hacker.noun
        time = Faker::Time.between(2.years.ago, Time.now, :all)
        project[:project_name] = proj_name 
        project[:description] = Faker::Hacker.say_something_smart
        project[:student_id] = id
        project[:position] = Faker::Name.title 
        project[:start_date] = time
        project[:end_date] = time.tomorrow
        Project.create! project
    end
end

puts "Done!"
