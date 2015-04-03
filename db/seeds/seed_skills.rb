puts "Seeding Skills..."

skills = File.open(File.join(Rails.root, 'db', 'seeds', 'db_seed_data/skills.txt')).read
skills.each_line do |name|
	skill = {}
	skill[:name] = name
	s = Skill.create!(skill)
	s.update_attributes(:id => s.id)
end

puts "Done!"