Given /the following staffs exist/ do |staffs_table|
  staffs_table.hashes.each do |staff|
    new_staff = Staff.create!({
      first_name: staff[:first_name],
      last_name: staff[:last_name], 
      account_id: staff[:account_id]
      })
  end
end

Given /the following data exist/ do
	require File.join(Rails.root, 'db', 'seeds', 'seed_students.rb')
	require File.join(Rails.root, 'db', 'seeds', 'seed_events.rb')
	require File.join(Rails.root, 'db', 'seeds', 'seed_jobs_and_companies.rb')
	require File.join(Rails.root, 'db', 'seeds', 'seed_colleges.rb')
	require File.join(Rails.root, 'db', 'seeds', 'seed_majors.rb')
	require File.join(Rails.root, 'db', 'seeds', 'seed_skills.rb')
	require File.join(Rails.root, 'db', 'seeds', 'seed_staffs.rb')
end