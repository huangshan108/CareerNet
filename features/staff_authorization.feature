Feature: Staff can post new events

  As a staff,
  I would like to post new events,
  So that students may view and register for them.

Background:

  Given the following accounts exist:
  |name            |email                    |account_type |
  |staff1          |staff1@berkeley.edu      |2            |
  |Example Company |company@careernet.com |3            |


  Given the following staffs exist:
  |first_name      |last_name      |email               |account_id |
  |Fake            |Staff          |staff1@berkeley.edu |1          |


   Given the following companies exist
  | title          | brief       | website          | address |account_id |          
  | Google         | Search      | Google.com       |  Soda   |2          |

  Given the following jobs exist
  | title          | description       | salary          | company_id |          
  | Director       | Frond-end         | 80000           |  1         |

  And I am on the account_login page
  Then I enter "staff1@berkeley.edu" into "email" 
  And I enter "careernet" into "password" 
  And I press "Log In" button
  Then I should see "Welcome to CareerNet"

Scenario: stuff can view any students' profile
  Given I am on list students page
  When I try to edit view this student profile page
  And I should not see "You don't have the persmission to perform the action."
  Then I should be on edit profile page

Scenario: stuff can visit other student application
  Then I am on the main dashboard page
  When I try visit student C application page
  And I should see "Unauthorized. Wrong user group."
  
  
  
