#assume we have a job table in database

Given /the following jobs exist/ do |jobs_table|
  jobs_table.hashes.each do |job|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that job to the database here.
    Job.create job
  end
end

When /^(?:|I )follow "([^"]*)"$/ do |link|
  click_link(link)
end

Then /^(?:|I )should be on (.+)$/ do |page_name|
  current_path = URI.parse(current_url).path
  if current_path.respond_to? :should
    current_path.should == path_to(page_name)
  else
    assert_equal path_to(page_name), current_path
  end
end

Then /^(?:|I )should see the company "(.*?)"/ do |job, company|

  Job.find_by_company(job).company.should eq company

end

Then /^(?:|I )should see the salary "(.*?)"/ do |job, salary|

  Job.find_by_salary(job).salary.should eq salary

end

end
