require 'csv'

puts "Seeding Colleges..."

college_data_file_path = File.join(Rails.root, 'db', 'seeds', 'db_seed_data/us_college_info.csv')
CSV.foreach(college_data_file_path, headers: true) do |row|
	College.create! row.to_hash
end

college_data_file_path = File.join(Rails.root, 'db', 'seeds', 'db_seed_data/us_college_info_2.csv')
CSV.foreach(college_data_file_path, headers: true) do |row|
	College.create! row.to_hash
end

puts "Done!"