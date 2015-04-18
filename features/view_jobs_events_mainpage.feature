Feature: Display upcoming jobs and events on main page

  As a student,
  I would like to see upcoming jobs and events
  So that I may apply to or attend them.

Background:

  Given the following events exist:
  | title           | description   | created_at                  |
  | Job Fair        | a             |   2015-03-24 00:43:43 UTC   |
  | Resume Workshop | b             |     2015-03-24 00:43:44 UTC |
  | Mock Interviews | c             |     2015-03-25 00:43:45 UTC |
  
  And the following jobs exist:
  | title     | description | time_start              |
  | Job1      | d           | 2000-01-01 15:00:00 UTC |
  | Job2      | e           | 2000-01-02 15:00:00 UTC |
  | Job3      | f           | 2000-01-03 15:00:01 UTC |

  And the following accounts exist:
  |name         | email               | account_type  |
  |huangshan108 | shuang@berkeley.edu | 1             |

  And the following students exist:
  | first_name      | last_name   | email               | account_id   |
  | Shan            | Huang       | shuang@berkeley.edu | 1            |

  And I am on the account_login page
  Then I enter "shuang@berkeley.edu" into "email"
  And I enter "careernet" into "password"
  And I press "Log In" button
  Then I should see "Welcome to CareerNet"

Scenario: I want to view an upcoming event
  
  Given I am on the main dashboard page
  Then I should see "Job Fair"
  When I follow "Job Fair"
  Then I should see "a"
  
Scenario: I want to view an upcoming job

  Given I am on the main dashboard page
  Then I should see "Job1"
  When I follow "Job1"
  Then I should see "d"
  
