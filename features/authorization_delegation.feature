Feature: Authorization and Delegation

  As a CareerNet_User
  I want to have my account secured 
  so that other user can't change or see the status on my account

Background: Adding users to database

  Given the following students exist:
  |name         |email                   |account_type |
  |student2     |student1@berkeley.edu   |1            |
  |student1     |student2@berkeley.edu   |1            |

  Given the following companies exist:
  |name         |email               |account_type |
  |Google       |google@berkeley.edu |3            |
  |Apple        |apple@berkeley.edu  |3            |

  Given the following staffs exist:
  |first_name         |last_name      |email               |account_id |
  |Fake               |Staff          |staff1@berkeley.edu |2          |

Scenario: Company can't view other companies job applications
  Given I am on the account_login page
  Then I enter "google@berkeley.edu.edu" into "email" 
  And I enter "careernet" into "password" 
  And I press "Log In" button
  Then I should see "Welcome to CareerNet"
  When I go to the Application page for "Apple"
  And I should see "You Don't have the access to edit it"
  And I should on the main dashboard page

Scenario: Company can't edit other student profile
  Given I am on the account_login page
  Then I enter "google@berkeley.edu" into "email" 
  And I enter "careernet" into "password" 
  And I press "Log In" button
  Then I should see "Welcome to CareerNet"
  When I go to the profile edit page for "student1"
  And I should see "You Don't have the access to edit it"
  And I should on the main dashboard page

Scenario: Student can't view other students profile
  Given I am on the account_login page
  Then I enter "student1@berkeley.edu" into "email" 
  And I enter "careernet" into "password" 
  And I press "Log In" button
  Then I should see "Welcome to CareerNet"
  When I go to the profile edit page for "student2"
  And I should see "You Don't have the access to edit it"
  And I should on the main dashboard page

Scenario: Stuff can have all access
  Given I am on the account_login page
  Then I enter "staff1@berkeley.edu" into "email" 
  And I enter "careernet" into "password" 
  And I press "Log In" button
  Then I should see "Welcome to CareerNet"
  When I go to the profile edit page for "student1"
  Then I should on the profile edit page for student1
  When I go to the Application page for "Apple"
  Then I should go to the Application page for "Apple"

