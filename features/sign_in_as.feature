Feature: Sign in as

  As a staff
  I want to sign in as a student, or a company representitive, to perform
  actions on behalf of them.

Background: Prepare database.

  Given the following events exist:
  | title           | description | time_start              | time_end                | location        |
  | Job Fair        | foo         | 2000-01-01 15:00:00 UTC | 2000-01-01 18:00:00 UTC | Anna Head       |
  | Resume Workshop | foo         | 2000-01-01 15:00:00 UTC | 2000-01-01 16:00:00 UTC | Gold Room       |
  | Mock Interviews | foo         | 2000-01-01 16:00:00 UTC | 2000-01-01 20:00:00 UTC | Wozniak Lounge  |

  Given the following accounts exist:
  |name          |email                     |account_type |
  |Test Student1 |test.student@berkeley.edu |1            |
  |Test Staff    |test.staff@berkeley.edu   |2            |
  |Test Company  |test.company@berkeley.edu |3            |
  |Test Student2 |test.student@berkeley.edu |1            | 

  Given the following students exist:
  |first_name         |last_name      |email                       |account_id |
  |Test               |Student1        | test.student@berkeley.edu |1          |
  |Test               |Student2        | test.student@berkeley.edu |4          |

  Given the following staffs exist:
  |first_name         |last_name      |email                   |account_id |
  |Fake               |Staff          |test.staff@berkeley.edu |2          |

  Given the following companies exist
  | title          | brief       | website          | address |account_id |          
  | Google         | Search      | Google.com       |  Soda   |3          |

And I am on the account_login page
Then I enter "test.student@berkeley.edu" into "email" 
And I enter "careernet" into "password" 
And I press "Log In" button
Then I should see "Welcome to CareerNet"
  
Scenario: I should be able to sign in as a studnet
  Given I am on students page
  And I should see "Student1"
  And I should see "Sign in as this student"
  When I follow "Sign in as this student"
  Then I should see "You currently signed in as Student1"

Scenario: I should edit student profile
  Given I am on student profile page
  And I should see "Edit Profile"
  When I follow "Edit Profile"
  Then I should be on edit profile page
  When I enter "Me" in "First name"
  And I follow "Submit"
  Then I should be on student profile page
  And I should see "Me"

Scenario: I should be able to make appointment
  Given I am on appointment page
  And I should be on student appointment page
  And I should not see "This page is for students only"
  When I follow "Make an appointment"
  Then I should be on make appointment page
  And I should see "Staff"
  When I follow "Book"
  Then I should be on student appointment page
  And I should see "Staff"

Scenario: I should be able to view events
  Given am on events page
  And I should see "Job Fair"
  And I should not see "Create an event"
  When I follow "Details"
  And I should be on the event detail page
  And I should see "Register"
  And I should not see "Delete"
  When I follow "Register"
  And I should be on my events page
  And I should see "Job Fair"

Scenario: I should be able to apply for a job
  Given I am on jobs page
  And I should see "Software Engineer"
  When I follow "Details"
  Then I should be on job detail page
  And I should see "Salary"
  And I should see "Apply"
  And I should not see "Delete"
  When I follow "Apply"
  Then I should see "Successfully Applied"
  And I should be on my application page
  And I should see "Software Engineer"

Scenario: I should be able to schedule interview
  Given I am on job application page
  And I should see "Software Engineer"
  And I should see "Status"
  And I should see "Interview pending"
  And I should see "Schedule interview"
  When I follow "Schedule interview"
  Then I should be on interview schedule page
  And I should see "Start Time"
  And I should see "Software Engineer"
  When I follow "Confirm"
  And I should be on upcoming interview page
  And I should see "10:00"