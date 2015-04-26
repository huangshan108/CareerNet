require 'time'
require 'references'
require 'roo'

puts "Seeding Client Data..."

# Open client data
sheet = Roo::Spreadsheet.open(File.join(Rails.root, 'db', 'seeds', 'db_seed_data/client_data.xlsx'))


resume_link = 'http://writing.colostate.edu/guides/documents/resume/functionalSample.pdf'
base_username = "careernet.student"
random_dates_list = []
random_dates = File.open(File.join(Rails.root, 'db', 'seeds', 'db_seed_data/random_dates.txt')).read
random_dates.each_line do |line|
    random_dates_list << Date.parse(line)
end

indestries_map = {
    "Technology / Telecom" => 1,
    "Advertising/Media/Entertainment" => 2,
    "Education/Govt/NonProfit/SE" => 3,
    "Consulting" => 4,
    "Financial Services" => 5,
    "Consumer Products/Retail" => 6,
    "Healthcare-BioPharma/Devices/Provider" => 7,
    "Real Estate" => 8,
    "Natural Resources" => 9,
    "Energy/Petroleum/Utilities" => 10,
    "Widely Diversified Manufacturing/Services" => 11,
    "Aerospace / Aviation / Defense" => 12,
    "Other" => 13
}

indestries_map.keys.each do |industry|
    Industry.create!(:industry => industry)
end

sheet.each(last_name: 'Last_Name', first_name: 'First_Name', gender: 'Gender',
           citizenship: 'Citizenship', job_title: 'JobTitle', yr_exp: 'Yr Experience',
           industry: 'General Industry', company: 'Org Name', salary: 'Base Salary',
           city: 'City', state: 'State', country: 'Country') do |hash|
    student = {}
    student[:first_name] = hash[:first_name]
    student[:last_name] = hash[:last_name]
    student[:major_id] = [1, 30, 90][rand(2)]
    student[:graduation_date] = random_dates_list.sample
    student[:college_id] = 1 + rand(10000)
    student[:resume_link] = resume_link
    student[:country] = hash[:citizenship]
    student[:college_id] = 6685 # University of California, Berkeley

    if hash[:gender].downcase == 'm'
        student[:gender] = 'male'
    elsif hash[:gender].downcase == 'f'
        student[:gender] = 'female'
    else
        student[:gender] = 'other'
    end
    s = Student.create! student

    account = {}
    account[:name] = base_username + "." + s.id.to_s
    account[:email] = base_username + "+" + s.id.to_s + "@gmail.com"
    account[:account_type] = 1
    account[:password] = "careernet"
    a = Account.create! account
    s.update_attributes(:account_id => a.id)

    experience = {}
    experience[:org_name] = hash[:company]
    experience[:job_title] = hash[:job_title]
    begin
        experience[:industry_id] = indestries_map[hash[:industry]]    
    rescue
    end
    experience[:yr_exp] = hash[:yr_exp]
    experience[:salary] = hash[:salary]
    experience[:city] = hash[:city]
    experience[:state] = hash[:state]
    experience[:country] = hash[:country]
    experience[:student_id] = s.id
    Experience.create! experience
end



puts "Done!"
