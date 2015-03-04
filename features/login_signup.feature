# Login/Signin
Feature: User sign up and log in
	
	As a user.
	I can login if I have an account already or signup if I don’t have one.
	I should be able to successfully signup/login and go to the home page.

Background: account shuang@berkeley.edu is not in the account table
	
Scenario: I don’t have an account and I try to login

	When I click to signup button
	Then I should go to the signup page
	If I don’t fill out email or password
	Then I should get an error

	Then I fill out my email shuang@berkeley.edu
	And I click signup button
	Then I should get an error

Scenario: I don’t have an account and I want to signup for one

	Then I enter password and re-enter a different password
	And I click signup button
	Then I should get an error

	Then I enter the password `mypassword` twice
	And I click signup button
	Then I should be successfully signup up with email shuang@berkeley.edu and password `mypassword`
	Then I should be redirected to ‘create profile page’

Scenario: I have an account and I want to login

	When I click the login button without filling out username or password
	Then I should get an error
	When I enter email shuang@berkeley.edu and a random password
	And I click login button
	Then I should get an error
	When I enter email shuang@berkeley.edu and password `mypassword`
	I should see the profile page

# we will not have a separated onboarding page. Instead, we will redirect people who haven’t completed their profile to the profile page.
# we will not have a skip button either. Instead, people can always skip by clicking another section in the navbar

Scenario: I just signed up and login

	When I click the home button in the navbar
	I should go to the home page
