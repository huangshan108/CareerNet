Feature: Calendar

  As a CareerNet user
  I want to view all my interviews, events and appointments
  on a single calendar.

Background: Events have been added to the database.

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

  Given the following appointments exist
  | staff_id       | student_id    | time_slot        | 
  | 1              | nil           | 1                |
  | 1              | 2             | 2                |


And I am on the account_login page
Then I enter "test.student@berkeley.edu" into "email" 
And I enter "careernet" into "password" 
And I press "Log In" button
Then I should see "Welcome to CareerNet"

@javascript
Scenario: Basic calendar view from Student
	Given I am on calendar page
	And I should see "My Calendar"
	And I should see "Jump To Date"
	And I should see "Interviews"
	And I should see "Events"
	And I should see "Appointments"
	And I should see "Personal events"
	And I should see "month"
	And I should see "week"
	And I should see "day"
	And I should see "today"
	When I follow "10"
	And I should see "10am"

@javascript
Scenario: Sign up for an appointment
	When I am on student appointment page
	And I should see "You currently do not have any active appointment."
	And I should see "Make a new appointment"
	When I follow "Make a new appointment"
	And I should be on student new appointment page
	And I should see "Book"
	And I should see "Not available"
	When I follow "Book"
	And I should see "Appointment has been made."

When I am on logout page
Then I should see "Logged out"

And I am on the account_login page
Then I enter "test.staff@berkeley.edu" into "email" 
And I enter "careernet" into "password" 
And I press "Log In" button
Then I should see "Welcome to CareerNet"

@javascript
Scenario: Basic calendar view from Staff
	Given I am on calendar page
	And I should see "My Calendar"
	And I should see "Jump To Date"
	And I should see "Interviews"
	And I should see "Events"
	And I should see "Appointments"
	And I should see "Personal events"
	And I should see "month"
	And I should see "week"
	And I should see "day"
	And I should see "today"

When I am on logout page
Then I should see "Logged out"

And I am on the account_login page
Then I enter "test.company@berkeley.edu" into "email" 
And I enter "careernet" into "password" 
And I press "Log In" button
Then I should see "Welcome to CareerNet"

@javascript
Scenario: Basic calendar view from Company
	Given I am on calendar page
	And I should see "My Calendar"
	And I should see "Jump To Date"
	And I should see "Interviews"
	And I should see "Events"
	And I should see "Appointments"
	And I should see "Personal events"
	And I should see "month"
	And I should see "week"
	And I should see "day"
	And I should see "today"