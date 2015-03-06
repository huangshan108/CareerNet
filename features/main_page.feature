# Main page
Feature: Main Page of CareerNet
	
	As a user.
	I want to be able to find easy to navigate tabs on main page
    so that I can find the functions of CareerNet that I want without an effort

Background: User has logged in with account student@berkeley.edu
	
Scenario: Navingating CareerNet with navigation tabs

	When I am on the main page
    And I click on the "" tab
	Then I should be directed to "" page

Scenario: Account info display on main page

	When I am on the main page
    I should see my welcome message signaling that I logged in
