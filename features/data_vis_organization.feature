Feature: Data Vistualization

  As a staff
  I want to view smart data reports
  So that I can have a overview of what people are doing.

Background: Events have been added to the database.

  Given the following data exist:

  And I am on the account_login page
  Then I enter "careernet.staff+1@gmail.com" into "email" 
  And I enter "careernet" into "password" 
  And I press "Log In" button
  Then I should see "Welcome to CareerNet"


@javascript
Scenario: I want to view smart data report

  Given I am on organization smart data report page
  Then I should see "Country"