puts "Seeding Companies..."

brief = 'Google is an American multinational corporation specializing in Internet-related services and products. These include online advertising technologies, search, cloud computing, and software. Most of its profits are derived from AdWords, an online advertising service that places advertising near the list of search results.'

base_username = "careernet.company"

companies = File.open(File.join(Rails.root, 'db', 'seeds', 'db_seed_data/random_company_names.txt')).read
companies.each_line do |line|
	company = {}
	company[:name] = line
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


description = 'On the other hand, we denounce with righteous indignation and dislike men who are so beguiled and demoralized by the charms of pleasure of the moment, so blinded by desire, that they cannot foresee the pain and trouble that are bound to ensue; and equal blame belongs to those who fail in their duty through weakness of will, which is the same as saying through shrinking from toil and pain. These cases are perfectly simple and easy to distinguish. In a free hour, when our power of choice is untrammelled and when nothing prevents our being able to do what we like best, every pleasure is to be welcomed and every pain avoided. But in certain circumstances and owing to the claims of duty or the obligations of business it will frequently occur that pleasures have to be repudiated and annoyances accepted. The wise man therefore always holds in these matters to this principle of selection: he rejects pleasures to secure other greater pleasures, or else he endures pains to avoid worse pains. At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae. Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat.'

random_job_title_list = []
random_job_titles = File.open(File.join(Rails.root, 'db', 'seeds', 'db_seed_data/random_job_titles.txt')).read
random_job_titles.each_line do |line|
	random_job_title_list << line.strip
end

comapny_count = Company.all.count
(1..500).each do
	job = {}
	job[:title] = random_job_title_list.sample
	job[:description] = description
	job[:salary] = rand(150000)
	job[:company_id] = 1 + rand(comapny_count - 1)
	Job.create!(job)
end
	

puts "Done!"
