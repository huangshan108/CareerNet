Feature: Staff can post new events

  As a staff,
  I would like to post new events,
  So that students may view and register for them.

Background:
  
   Given the following events exist:

  | title           | description   |time_start               |time_end                 |
  | Job Fair        | a             |2000-01-01 15:00:00 UTC  |2000-01-01 15:00:00 UTC  |
  | Resume Workshop | b             |2000-01-01 15:00:00 UTC  |2000-01-01 15:00:00 UTC  |
  | Mock Interviews | c             |2000-01-01 15:00:00 UTC  |2000-01-01 15:00:00 UTC  |

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

Scenario: I want to post a new event
  
  Given I am on the events page
  Then I should not see "Tech Talk"
  When I follow "Create New Event"
  And I enter "Tech Talk" into "title"
  And I press "Create"
  Then I am on the events page
  And I should see "Tech Talk"
  
Scenario: I want to delete an event
  
  Given I am on the events page
  Then I should see "Resume Workshop"
  When I follow "Resume Workshop"
  And I follow "Delete"
  Then I am on the events page
  And I should not see "Resume Workshop"
  
