Given /the following accounts exist/ do |accounts_table|
  accounts_table.hashes.each do |account|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    account[:password] = "careernet"
    if account[:name] == "expired"
      account[:password_reset_sent_at] = Time.zone.now - 86400
      account[:password_reset_token] = "test_token_expired"
    else
      account[:password_reset_sent_at] = Time.zone.now
      account[:password_reset_token] = "test_token"
    end
    Account.create!(account)
  end
end

When(/^I press "(.+)" button$/) do |button|
	# visit current_page
  press_button button 
end

Then /^I enter "(.+)" into "(.+)"/ do |value1, field1|
  enter_stuff value1, field1
end

And /^I log in$/ do
  visit current_page
  enter_stuff "shuang@berkeley.edu", "email"
  enter_stuff "careernet", "password"
  press_button "Log In"
end


When(/^I fill in signup form with invalid email$/) do
  enter_stuff "careernet", "username"
  enter_stuff "careernet@", "email"
  enter_stuff "careernet", "password"
  press_button "Sign Up"
end

When(/^I fill in signup form with two different passwords$/) do
  enter_stuff "careernet", "username"
  enter_stuff "careernet@berkeley.edu", "email"
  enter_stuff "careernet1", "password"
  press_button "Sign Up"
end

When(/^I fill in signup form with email "(.*?)"$/) do |email|
  enter_stuff "careernet", "username"
  enter_stuff email, "email"
  enter_stuff "careernet", "password"
  press_button "Sign Up"
end

When(/^I fill in reset password form with email "(.*?)"$/) do |email|
  enter_stuff email, "email"
  press_button "Reset Password"
end

When(/^I fill in reset password form with password1 "(.*?)" and password2 "(.*?)"$/) do |password1, password2|
  visit "account/start-reset-password/test_token"
  enter_stuff password1, "password"
  press_button "Reset Password"
end

When(/^I fill in reset password form with password1 "(.*?)" and password2 "(.*?)" in the expired link$/) do |password1, password2|
  visit "account/start-reset-password/test_token_expired"
  enter_stuff password1, "password"
  press_button "Reset Password"
end

def press_button selector
	find('input[value="' + selector + '"]').click
end

def enter_stuff value, field
	find('input[name="' + field + '"]').set(value)
end