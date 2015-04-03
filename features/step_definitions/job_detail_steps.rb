#create jobs table
Given /the following jobs exist/ do |jobs_table|
  jobs_table.hashes.each do |job|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    new_job = Job.create!(title: job[:title], description: job[:description],  company_id: job[:company_id], salary: job[:salary])
    new_job.save
  end
end

Then /I should see "(.*?)" before "(.*?)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  e1_index = page.body.index(e1)
  e2_index = page.body.index(e2)
  if e1_index > e2_index
    raise Exception.new("Page Element Order Error")
  end
end

And /^(?:|I )should see the button "(.*?)"/ do 
  #page.should have_button()
end

Given /I am logged in/ do

end
