#assume we have a job table in database

Given /^I am on the apply page/ do
  #apply_path
end

Then /^(?:|I )should see job's "(.*?)"/ do |title,company,salary,description|
  page.should have_content(title)
  page.should have_content(company)
  page.should have_content(salary)
  page.should have_content(description)
end

And /^(?:|I )should see the button "(.*?)"/ do 
  #page.should have_button()
end


