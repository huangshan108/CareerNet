Feature: Interview scheduling and management for students

  As a student,
  I want to see, consider, and schedule offered interviews,
  So that I can interview with companies.

Background:

  Given the following accounts exist:
  | name         | email                 | account_type |
  | huangshan108 | shuang@berkeley.edu   | 1            |
  | company1     | company@careernet.com | 3            |

  Given the following students exist:
  | first_name    | last_name          | email                | account_id |
  | Shan          | Huang              | shuang@berkeley.edu  | 1          |

  Given the following companies exist:
  | title        | brief              | website     | address      | account_id |
  | Google       | Search             | google.com  | Soda         | 2          |

  Given the following jobs exist:
  | title        | description        | salary      | company_id |
  | Director     | Front-end          | 80000       | 1          |

  And I am on the account_login page
  Then I enter "shuang@berkeley.edu" into "email"
  And I enter "careernet" into "password"
  And I press "Log In" button
  Then I should see "Welcome to CareerNet"

  Given I am on the job 1 view page
  When I follow "Apply"
  Then I should see "You application has been submitted!"
  When I am on the main dashboard page
  When I follow "View Applications"
  Then I should see "Director"

@javascript
Scenario: Accept interview time with company

  When I follow "View Details"
  Then I should see "Schedule Interview"
  Then I am on logout page
  Then I am on the account_login page
  When I enter "company@careernet.com" into "email"
  And I enter "careernet" into "password"
  And I press "Log In" button
  Then I should see "Welcome to CareerNet"
  When I follow "View Applications"
  Then I should see "Shan Huang"
  When I follow "View/Schedule Interview"
  Then I should see "interview slots"
  Then I am on logout page
  Then I am on the account_login page
  When I enter "shuang@berkeley.edu" into "email"
  And I enter "careernet" into "password"
  And I press "Log In" button
  And I follow "View Applications"
  And I follow "View Details"
  Then I should see "Schedule Interview"
  And I should see "Back to My Interviews"
  When I follow "Back to My Interviews"
  Then I should see "Interviews"
  And I should see "Interview Date"


@javascript
Scenario: Adding interview slots student side
  Given I am on the main page
  Given the following interviews exist: 
  | time_slot    | day               | application_id | student_id | company_id |
  | Slot1        | middle_of_day     | 1              | 1          | 1          |
  And I follow "View Applications"
  And I follow "View Details"
  Then I should see "Interview Date"
  And I should see "Cancel"
  When I follow "Cancel"
  Then I should see "You currently do not have any scheduled interviews."
  When I follow "Back to My Applications"
  And I follow "View Details"
  Then I should see "Book"
  When I follow "Book"
  Then I should see "Interview has been scheduled."
