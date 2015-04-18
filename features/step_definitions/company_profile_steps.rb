When(/^I fill in Company Name with "(.*?)"$/) do |arg1|
  fill_in "name", :with => arg1
end