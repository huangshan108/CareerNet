puts "Seeding Companies..."

brief = 'Google is an American multinational corporation specializing in Internet-related services and products. These include online advertising technologies, search, cloud computing, and software. Most of its profits are derived from AdWords, an online advertising service that places advertising near the list of search results.'

base_username = "careernet.company"

companies = File.open(File.join(Rails.root, 'db', 'seeds', 'db_seed_data/company_names.txt')).read
companies.each_line do |line|
	company = {}
	company[:name] = line.strip
	company[:brief] = brief
	company[:website] = "http://www.berkeley.edu/"
	company[:address] = "387 Soda Hall, Berkeley, CA 94720"
	c = Company.create!(company)
	account = {}
	account[:name] = base_username + "." + c.id.to_s
	account[:email] = base_username + "+" + c.id.to_s + "@gmail.com"
	account[:account_type] = 3
	account[:password] = "careernet"
	a = Account.create!(account)
	c.update_attributes(:account_id => a.id)
end

puts "Done!"
puts "Seeding Jobs..."


description = "<p>Sports media is filled with 50-year-old white guys in suits screaming “what’s real,” athletes reading scripted statements and mindless “breaking news” on repeat. We deserve better sports media - content driven by purpose, truth and the people.</p><p>This is why we started Grit - a sports media startup powered by real stories for real people. Everyday, we produce and distribute original digital stories (videos and photos) that extend beyond the scores and dives into the real, raw, authentic grit of sports culture. We believe in the power of sports (youth to pro) to highlight mind-blowing individuals, uncover social issues and inspire greatness.</p><p>Our team has backgrounds in media, technology and sports (Upworthy, ESPN, Google, Pinterest, Yammer, NBA, NFL). They believe in our vision to disrupt old sports media, because they believe in a future of better sports media.</p><p>Position: Brand Identity Intern</p><p>We are looking for someone to join Grit’s Creative team and help create a consistent flow of photographic and graphic narratives for our website. We are based in Oakland, but this position can also be filled remotely by people outside of the San Francisco Bay Area.</p><p>We are hoping to add a full-time person to our R&D team who has a strong background in either general fabrication (woodworking, metalworking, and composites) and/or design and engineering. The ideal candidate also has experience with or interest in how these skills are applied to ultra-lightweight marine platforms. Because we often complete projects on an aggressive schedule with a relatively short period of preparation, this position presents a unique opportunity for design and engineering to occur on the shop floor. The ideal candidate will be able to make to design changes and tight deadlines and will be equally at ease working independently and collaborating with other team members to solve problems. All full-time team members will be involved in on-water testing. This step closes the design loop and allows everyone to gain firsthand experience and perspective on the choices that were made during the build process.</p><p>To assist with multiple phases of ultra-lightweight boat development, maintenance, and repair. These phases include: use of CAD programs, use of CAM machines, plug and mold construction, lamination and vacuum infusion with fiberglass and carbon fiber, vacuum bagging of laminates, grinding and sanding, secondary bonding with structural glues, and kite rigging.</p><p>To assist during boat tests as crew on either the kiteboat, the support boat, or the shore support team.</p>"

job_title_list = []
job_titles = File.open(File.join(Rails.root, 'db', 'seeds', 'db_seed_data/job_titles.txt')).read
job_titles.each_line do |line|
	job_title_list << line.strip
end

comapny_count = Company.all.count
(1..1500).each do
	job = {}
	job[:title] = job_title_list.sample
	job[:description] = description
	job[:salary] = rand(150000)
	job[:company_id] = 1 + rand(comapny_count - 1)
	Job.create!(job)
end
	

puts "Done!"
