all_majors = File.open(File.join(Rails.root, 'db', 'seeds', 'db_seed_data/all_majors.txt')).read
all_majors.each_line do |line|
	major = {}
	major[:name] = line
	Major.create!(major)
end

puts "Done!"