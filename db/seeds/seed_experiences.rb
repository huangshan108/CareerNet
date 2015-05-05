
puts "Seeding Experiences..."

states = ["Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", 
          "Connecticut", "Delaware", "District of Columbia", "Florida",
          "Georgia", "Idaho", "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky",
          "Louisiana", "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota",
          "Mississippi", "Missouri", "Montana", "Nebraska", "Nevada", "New Hampshire",
          "New Jersey", "New Mexico", "New York", "North Carolina", "North Dakota", "Ohio", 
          "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island", "South Carolina", "South Dakota",
          "Tennessee", "Texas", "Utah", "Vermont", "Virginia", "Washington", "West Virginia", 
          "Wisconsin", "Wyoming"]

Student.all.count.times do |id|
    rand(1..3).times do |i|
        experience = {}
        experience[:yr_exp] = rand(1..5) 
        experience[:salary] = rand(90000..150000)
        experience[:city] = Faker::Address.city 
        experience[:state] = states[rand(1..50)]
        experience[:country] = "US"
        experience[:student_id] = id
        experience[:company_id] = rand(1..Company.all.count)
        experience[:job_title] = Faker::Name.title
        experience[:industry_id] = rand(1..Industry.all.count)
        Experience.create! experience
    end
end
