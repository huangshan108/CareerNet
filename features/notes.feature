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
  Then I should see "Your application has been submitted!"
  When I am on the main dashboard page
  When I follow "View Applications"
  Then I should see "Director"

Scenario: As a student, enter a reason for scheduling an appointment

  Given the following appointments exist:
  | time_slot   | day               | staff_id   |
  | Slot1       | middle_of_day     | 1          |
  Given I am on the main page
  And I follow "Make An Appointment"
  Then I am on student appointment page
  When I follow "New Appointment"
  Then I am on student new appointment page
  When I follow "Book"
  Then I should see "Reason"
  And I should see "Description"
  When I press "Submit" button
  Then I should see "Fake Staff"
  When I follow "Logout"
  Then I am on the account_login page
  When I enter "staff@careernet.com" into "email"
  And I enter "careernet" into "password"
  And I press "Log In" button
  Then I am on the main page
  When I am on appointment page
  Then I should see "Reason"
  And I should see "Description"
  And I should see "Staff Feedback"
  And I should see "Add Feedback"
  And I press "Submit" button
  When I am on logout page
  When I enter "shuang@berkeley.edu" into "email"
  And I enter "careernet" into "password"
  And I press "Log In" button
  Then I should see "Welcome to CareerNet"
  When I am on student appointment page
  And I follow "Cancel"

@javascript
Scenario: As staff, add notes to students

  Given I am on the main page
  Then I am on logout page
  When I enter "staff@careernet.com" into "email"
  And I enter "careernet" into "password"
  And I press "Log In" button
  Then I am on the main page
  When I am on edit profile page
  Then I should see "Notes"
  And I press "Submit" button
  Given I am on the main page
  And I follow "Post An Appointment"
  When I press the css button ".fc-button.fc-button-next.fc-state-default.fc-corner-right"
  When I press the css button ".fc-slot0 td.fc-widget-content"
