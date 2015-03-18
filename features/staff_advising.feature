# Advising session
Feature: Scheduling an advising session

    As a staff
    So that I can help the student to be competitive in the job market
    I want to schedule an appointment with students


Background:
    Given that following advisors have set up several appointment slots
    | Advisor Name     | Slots                                        | Description                     |
    | Nina Cauliflower | 9:20-10:00 3/13/2015                         | I specialize in resume reviews  |
    | Tim Basketball   | 15:10-15:30 4/28/2015                        | I specialize in mock interviews |
    | James Frog       | 10:00-10:30 2/25/2015, 14:30-15:00 3/14/2015 | I am not really a frog          |

    Given that following students set up appointment with the said advisor:
    | Student Name     | Slots                 | Advisor Name | Description                                 |
    | Flora Bagpipe        | 10:00-10:30 2/25/2015 | James Frog   | I want to do a resume review                |


Scenario: Checking my advising sessions
    When I am on the main page
    And I press the "My appointments" button on navigation bar
    I should see a list of "James Frog" available times on the page
    And I should see "Booked" next to slot "10:00-10:30 2/25/2015"
    When I click slot "10:00-10:30 2/25/2015"
    I should be on details page for that advising slot with student "Flora Bagpipe"
    And I should see button "Cancel Appointment" on that page

Scenario: Setting up for advising session
    When I am on the main page
    And I press the "My appointments" button on navigation bar
    I should see a list of "James Frog" available times on the page
    When I click on a button "Create Appointment Slot"
    And I fill out the form with "10:00-10:30 1/11/2015" and submit
    Then I should see "10:00-10:30 1/11/2015" listed as my available slot

Scenario: Canceling an appointment
    When I am on the main page
    And I click the "My appointments" button on navigation bar
    And I click "10:00-10:30 2/25/2015" from appointment slots
    And I click "Cancel Appointment"
    Then I should no longer see "10:00-10:30 2/25/2015" as my appointment slots

