Feature: Appointment, interview, and general notes for all users

  As a user,
  I want to add notes,
  So that I can record notes, feedback, etc. on students.

Background:

  Given the following accounts exist:
  | name         | email                 | account_type |
  | huangshan108 | shuang@berkeley.edu   | 1            |
  | staff1       | staff@careernet.com   | 2            |
  | company1     | company@careernet.com | 3            |

  Given the following students exist:
  | first_name    | last_name          | email                | account_id |
  | Shan          | Huang              | shuang@berkeley.edu  | 1          |

  Given the following staffs exist:
  | first_name    | last_name          | email                | account_id |
  | Fake          | Staff              | staff@careernet.com  | 2          |

  Given the following companies exist:
  | title        | brief              | website     | address      | account_id |
  | Google       | Search             | google.com  | Soda         | 3          |

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

Scenario: As a student, enter a reason for scheduling an appointment

  Given the following appointments exist:
  | time_slot   | day               | student_id  | staff_id   |
  | Slot1       | middle_of_day     | 1           | 1          |
  Given I am on the main page
  And I follow "Make an Appointment"
  And I follow "Make a new appointment"
  And I follow "Book"
  Then I should see "Reason for appointment"
  And I should see "Mock interview"
  And I should see "Resume advice"
  And I should see "Job search"
  And I should see "Other"
  And I select "Job search"
  When I press "Submit" button
  Then I should see "Fake Staff"
  When I follow "Logout"
  Then I am on the account_login page
  When I enter "staff@careernet.com" into "email"
  And I enter "careernet" into "password"
  And I press "Log In" button
  Then I am on the main page
  When I follow "My Calendar"
  And I follow "Shan Huang"
  Then I should see "Reason for appointment"
  And I should see "Job search"

Scenario: As staff, add notes to students

  Given I am on the main page
  When I follow "Logout"
  Then I am on the account_login page
  When I enter "staff@careernet.com" into "email"
  And I enter "careernet" into "password"
  And I press "Log In" button
  Then I am on the main page
  When I follow "Browse Students"
  Then I should see "Shan Huang"
  When I follow "Shan Huang"
  Then I should see "Notes"
  When I press "Edit Notes" button
  And I enter "Sample notes here" into "notes"
  And I press "Submit" button
  Then I should see "Sample notes here"

Scenario: As a company, send feedback to interviewee

  Given I am on the main page
  When I follow "Logout"
  Then I am on the account_login page
  When I enter "company@careernet.com" into "email"
  And I enter "careernet" into "password"
  And press "Log In" button
  Then I am on the main page
  Given the following interviews exist:
  | time_slot    | day               | application_id | student_id | company_id |
  | Slot1        | middle_of_day     | 1              | 1          | 1          |
  And I follow "View Applications"
  And I follow "View Details"
  Then I should see "Add Feedback"
  When I press "Add Feedback" button
  And I enter "Sample feedback here" into "feedback"
  And I press "Submit" button
  Then I should see "Sample feedback here"
  When I follow "Logout"
  Then I am on the account_login page
  When I enter "shuang@berkeley.edu" into "email"
  And I enter "careernet" into "password"
  And I press "Log In" button
  Then I am on the main page
  When I follow "View Applications"
  Then I should see "Director"
  When I follow "View Details"
  And I follow "View Feedback"
  Then I should see "Sample feedback here"

