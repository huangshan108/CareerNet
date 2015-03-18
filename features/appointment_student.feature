Feature: Students can make appointments with advisers
    As a student, I want to make an appointment with an adviser that is available

Background: Appointments to database

    Given the following students exist:
    | first_name   | last_name  | college_id   | major_id     | graduation_date   | resume_link |
    | Mark         | Sharp      | 1            | 1            | 2016-10-10        | example.com |

    Given the following faculty exist:
    | faculty_name  | email            |
    | Jean Smith    | test@example.com |

    Given the following appointments exist:
    | faculty_name  | Start Time                                | End Time                                |
    | Jean Smith    | Wed Mar 18 2015 12:20:00 GMT-0700 (PDT)   | Wed Mar 18 2015 12:40:00 GMT-0700 (PDT) |
    
    Scenario: View Available Faculties
        Given I am on make apointments page
        Then I should see "Jean Smith"
        Then I should see "Schedule an appointment"

    Scenario:  View appointments
        Given I am on make appointment page
        When I follow "Schedule an appointment"
        Then I should be on available appointments page
        And I should not see "Wed Mar 18 2015 12:20:00 GMT-0700 (PDT)"
   
    Scenario: Edit student profile
        Given I am on available appointments page
        And I should see "Wed Mar 18 2015 13:00:00 GMT-0700 (PDT)"
        And I follow "Wed Mar 18 2015 13:00:00 GMT-0700 (PDT)"
        And I should see "Appointment with Jean Smith Scheduled"
        And I should not see "Wed Mar 18 2015 13:00:00 GMT-0700 (PDT)"

    Scenario: View scheduled Appointments
        Given I am on home page
        And I should see "You have 1 appointment with Jean Smith"
        Then I follow "appointment"
        And I should be on existing appointments page
        And I should see "Calendar"
        And I should see "Jean Smith"

    Scenario: Cancel Appointment
        Given I am on existing appointments page
        Then I follow "Cancel Appointment"
        And I should see "Appointment with Jean Smith has been canceled"
        And I should not see "Wed Mar 18 2015 13:00:00 GMT-0700 (PDT)"
        And I should see "No appointment is scheduled at this time."