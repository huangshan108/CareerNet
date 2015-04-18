Feature: Staff can create and/or modify profiles
    As a Staff Member
    I want to update our profile
    So that students can look up certain staff members if they need help

Background: Adding jobs to database

  Given the following events exist:
  | title           | description   | 
  | Job Fair        | a             |
  | Resume Workshop | b             |
  | Mock Interviews | c             |

  Given the following accounts exist:
  |name         |email               |account_type |
  |huangshan108 |shuang@berkeley.edu |1            |
  |staff1       |staff1@berkeley.edu |2            |

  Given the following students exist:
  |first_name         |last_name      |email               |account_id |
  |Shan               |Huang          |shuang@berkeley.edu |1          |

  Given the following staffs exist:
  |first_name         |last_name      |email               |account_id |
  |Fake               |Staff          |staff1@berkeley.edu |2          |

  And I am on the account_login page
  Then I enter "staff1@berkeley.edu" into "email" 
  And I enter "careernet" into "password" 
  And I press "Log In" button
  Then I should see "Welcome to CareerNet"

  Scenario: Edit staff profile
    Given I am on staff profile page
    And I follow "Edit profile"
    When I fill in First Name with "Steve"
    And I fill in "description" with "This is a test"
    And I press "Submit"
    Then I should see "Steve"
    And I should see "This is a test"