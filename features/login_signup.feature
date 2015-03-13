# Login/Signin
Feature: User sign up and log in
	
	As a user.
	I can login if I have an account already or signup if I don’t have one.
	I should be able to successfully signup/login and go to the home page.

Background:
	Given the following accounts exist:
	|name         |email               |account_type |
	|huangshan108 |shuang@berkeley.edu |1            |
	|expired      |expired@berkeley.edu|2            |
	
Scenario: I don't input anything and try to login
	I am on the CareerNet "/account/login" page 
	When I press "Log In" button
	Then I should see "Invalid username/password combination."

Scenario: I type a wrong password
	I am on the CareerNet "/account/login" page
	Then I enter "shuang@berkeley.edu" into "email" and I enter "wrongpassword" into "password" and I press "Log In" button
	Then I should see "Invalid username/password combination."

Scenario: I type a correct password
	I am on the CareerNet "/account/login" page
	Then I enter "shuang@berkeley.edu" into "email" and I enter "careernet" into "password" and I press "Log In" button
	Then I should see "Welcome to CareerNet"

Scenario: I want to signup but type in invalid email
	I am on the CareerNet "/account/signup" page
	When I fill in signup form with invalid email
	Then I should see "Invalid field. Please check your email or password."

Scenario: I want to signup with an existing account
	I am on the CareerNet "/account/signup" page
	When I fill in signup form with email "shuang@berkeley.edu"
	Then I should see "Email already exist."

Scenario: I successfully signed up
	I am on the CareerNet "/account/signup" page
	When I fill in signup form with email "careernet@berkeley.edu"
	Then I should see "Account successfully created!"

Scenario: I want to reset my password but I type in a invalid email.
	I am on the CareerNet "/account/forgot-password" page
	When I fill in reset password form with email "careernet@berkeley.edu"
	Then I should see "Account not found!"

Scenario: I want to reset my password and I type in a valid email.
	I am on the CareerNet "/account/forgot-password" page
	When I fill in reset password form with email "shuang@berkeley.edu"
	Then I should see "follow the instructions to reset your password."

Scenario: I am successfully reset a password
	I am on the CareerNet "account/start-reset-password/test_token" page.
	When I fill in reset password form with password1 "careernet" and password2 "careernet"
	Then I should see "Password reset successfully!"

Scenario: I fail to reset a password
	I am on the CareerNet "account/start-reset-password/test_token" page.
	When I fill in reset password form with password1 "careernet" and password2 "careernet2"
	Then I should see "Password does not match!"

Scenario: I reset password on an expired link
	I am on the CareerNet "account/start-reset-password/test_token_expired" page.
	When I fill in reset password form with password1 "careernet" and password2 "careernet" in the expired link
	Then I should see "Password reset link has expired."