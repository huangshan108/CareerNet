Feature: View Events

  As a student
  I want to view and register for upcoming events
  So that I can improve my chances of landing a job.

Background: Events have been added to the database.

  Given the following events exist:
  | title           | description | time_start              | time_end                | location        |
  | Job Fair        | foo         | 2000-01-01 15:00:00 UTC | 2000-01-01 18:00:00 UTC | Anna Head       |
  | Resume Workshop | foo         | 2000-01-01 15:00:00 UTC | 2000-01-01 16:00:00 UTC | Gold Room       |
  | Mock Interviews | foo         | 2000-01-01 16:00:00 UTC | 2000-01-01 20:00:00 UTC | Wozniak Lounge  |

  Given the following accounts exist:
  |name         |email               |account_type |
  |huangshan108 |shuang@berkeley.edu |2            |

  Given the following staffs exist:
  |first_name         |last_name      |email               |account_id |
  |Fake               |Staff          |staff1@berkeley.edu |1          |

  And I am on the account_login page
  Then I enter "shuang@berkeley.edu" into "email" 
And I enter "careernet" into "password" 
And I press "Log In" button
  Then I should see "Welcome to CareerNet"

  Scenario: I want to view a recruiting event

  Given I am on the events page
  When I follow "Job Fair"
  Then I should see "Job Fair"
  And I should see "01/01/00"
  And I should see "Register"
  And I should see "Back"

Scenario: I want to view a resume workshop

  Given I am on the events page
  When I follow "Resume Workshop"
  Then I should see "Resume Workshop"
  And I should see "01/01/00"
  And I should see "Register"
  And I should see "Back"

Scenario: I want to register for a mock interview

  Given I am on the events page
  When I follow "Mock Interviews"
  Then I should see "Mock Interviews"
  And I should see "01/01/00"
  And I should see "Register"
  And I should see "Back"
  And I should see "foo"
  When I follow "Back"
  Then I am on the events page

Scenario: As a staff member I want to Create New Event

  Given I am on the events page
  When I follow "Create New Event"
  Then I should see "Create New Event"
  When I press "Create"
  Then I am on the events page

Scenario: As a staff member I want to delete an event

  Given I am on the events page
  When I follow "Mock Interviews"
  Then I should see "Mock Interviews"
  When I follow "Delete"
  Then I am on the events page
  And I should not see "Mock Interviews"

Scenario: As a user I want to see all my registered events
  Given I am on the events page
  When I follow "Job Fair"
  And I follow "Register"
  Then I am on the events page
  When I follow "Resume Workshop"
  And I follow "Register"
  Then I am on the events page
  Given I am on the main page
  And I follow "View Registered Events"
  Then I should see "My Events"
  And I should see "Job Fair"
  And I should see "Resume Workshop"
  And I should not see "Mock Interviews"

Scenario: As a staff member I want to see all attendees to an event
  Given I am on the events page
  When I follow "Job Fair"
  And I follow "Register"
  Then I am on the events page
  When I follow "Job Fair"
  And I follow "View Attendees"
  Then I am on attendees page

