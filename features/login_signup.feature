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

	Given the following students exist:
	|first_name         |last_name			|email               |account_id |
	|shuang             |Huang          |shuang@berkeley.edu |1          |

Scenario: I don't input anything and try to login
	Given I am on login page
	Then I should see "CareerNet" 
	When I press "Log In" button
	Then I should see "Invalid username/password combination."

Scenario: I type a wrong password
	Given I am on login page
	Then I enter "shuang@berkeley.edu" into "email"
	And I enter "wrongpassword" into "password"
	Then I press "Log In" button
	Then I should see "Invalid username/password combination."

Scenario: I type a correct password
	Given I am on login page
	Then I enter "shuang@berkeley.edu" into "email"
	And I enter "careernet" into "password" 
	And I press "Log In" button
	Then I should see "Welcome to CareerNet"

Scenario: I want to signup but type in invalid email
	Given I am on signup page
	When I fill in signup form with invalid email
	Then I should see "Invalid field. Please check your email or password."

Scenario: I want to signup with an existing account
	Given I am on signup page
	When I fill in signup form with email "shuang@berkeley.edu"
	Then I should see "Email already exists."

Scenario: I successfully signed up
	Given I am on signup page
	When I fill in signup form with email "careernet@berkeley.edu"
	Then I should see "Account successfully created!"

Scenario: I want to reset my password but I type in a invalid email.
	Given I am on forgot password page
	When I fill in reset password form with email "careernet@berkeley.edu"
	Then I should see "Account not found!"

Scenario: I want to reset my password and I type in a valid email.
	Given I am on forgot password page
	When I fill in reset password form with email "shuang@berkeley.edu"
	Then I should see "follow the instructions to reset your password."

Scenario: I am successfully reset a password
	I am on CareerNet "account/start-reset-password/test_token" page.
	When I fill in reset password form with password1 "careernet" and password2 "careernet"
	Then I should see "Password reset successfully!"

Scenario: I reset password on an expired link
	I am on the CareerNet "account/start-reset-password/test_token_expired" page.
	When I fill in reset password form with password1 "careernet" and password2 "careernet" in the expired link
	Then I should see "Password reset link has expired."

Scenario: I logged out
	Given I am on login page
	Then I enter "shuang@berkeley.edu" into "email" 
	And I enter "careernet" into "password" 
	And I press "Log In" button
	Then I should see "Welcome to CareerNet"
	When I follow "Logout"
	Then I should see "Logged out"
