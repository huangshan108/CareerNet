#create jobs table
Given /the following jobs exist/ do |jobs_table|
  jobs_table.hashes.each do |job|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    new_job = Job.create!(title: job[:title], description: job[:description],  company: job[:company], salary: job[:salary])
    new_job.save
  end
end


#see job
Then /^(?:|I )should see "([^"]*)"$/ do |text|
  if page.respond_to? :should
    page.should have_content(text)
  else
    assert page.has_content?(text)
  end
end

Then /^(?:|I )should not see "([^"]*)"$/ do |text|
  if page.respond_to? :should
    page.should have_no_content(text)
  else
    assert page.has_no_content?(text)
  end
end

#assume we have a job table in database

Then /I should see "(.*?)" before "(.*?)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  e1_index = page.body.index(e1)
  e2_index = page.body.index(e2)
  if e1_index > e2_index
    raise Error
  end
end

Given /^(?:|I )am on the (.+)$/ do |page_name|
  visit path_to(page_name)
end

And /^(?:|I )should see the button "(.*?)"/ do 
  #page.should have_button()
end

When /^(?:|I )follow "([^"]*)"$/ do |link|
  click_link(link)
end


