# Advising session
Feature: Scheduling an advising session

    As a student
    So that I can get the help I need to be competitive in the job market
    I want to schedule an appointment with the advisor


Background:

    Given that following advisors have set up several appointment slots
    | Name              | Slots                                        | Description                     |
    | Nina Cauliflower  | 9:20-10:00 3/13/2015                         | I specialize in resume reviews  |
    | Tim Basketball    | 15:10-15:30 4/28/2015                        | I specialize in mock interviews |
    | James Frog        | 10:00-10:30 2/25/2015, 14:30-15:00 3/14/2015 | I am not really a frog          |

Scenario: Navigating the Advising page

    When I click on the tab "Advising" on the navbar
    I should see a list of advisors: Nina Cauliflower, Tim Basketball, James Frog
    When I click on "Nina Cauliflower"
    I should be redirected to a page with description of "Nina Cauliflower"
    And I should see a "Sign Up" button


Scenario: Signing up for advising session

    When I am on the personal page of an "Nina Cauliflower"
    And I click the "Sign Up" button
    I should see a list of Nina Cauliflower's available time slots
    And I should see a drop down menu for reasons of appointment
    When I choose the reason of appointment and time slot "9:20-10:00 3/13/2015"
    And click "submit"
    I should be back on the personal page of "Nina Cauliflower"
    And I should see on the top of the page a confirmation message:
    You have successfully signed up for an appointment with Nina Cauliflower at a9:20-10:00 3/13/2015 


Scenario: Checking my scheduled session

    When I have signed up for an appointment with "James Frog" at "10:00-10:30 2/25/2015"
    And I click on the tab "Advising" on the navbar
    I should see on the side of the page a title "My appointments"
    I should see below my appointment with "James Frog" at "10:00-10:30 2/25/2015"

    When I click on "James Frog" 
    I should be redirected to a page with description of "James Frog" and appointment time
    And I should see a button "Cancel Appointment"


Scenario: Canceling an appointment

    When I have signed up for an appointment with "James Frog" at "10:00-10:30 2/25/2015"
    When I am on the "Advising" page
    And I click "James Frog" which appointment I want to cancel
    Then I click "Cancel Appointment" on redirected page
    I should see the main "Advising" page
    And I should see the confirmation message on the top of the page:
    You have successfully canceled appointment with James Frog at 10:00-10:30 2/25/2015
    And I should no longer see "James Frog" under "My appointments"
