Feature: Data Vistualization

  As a staff
  I want to view smart data reports
  So that I can have a overview of what people are doing.

Background: Events have been added to the database.

#  Given the following data exist:
  Given the following accounts exist:
  | name     | email                       | account_type |
  | staff    | careernet.staff+1@gmail.com | 2            |

  Given the following staffs exist:
  | first_name  | last_name    | account_id |
  | Fake        | Staff        | 1          |

  And I am on the account_login page
  Then I enter "careernet.staff+1@gmail.com" into "email" 
  And I enter "careernet" into "password" 
  And I press "Log In" button
  Then I should see "Welcome to CareerNet"


@javascript
Scenario: I want to view smart data report

  Given I am on smart data report page
#  Then I should see "Country"
