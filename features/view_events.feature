As a student
I want to view and register for upcoming events
So that I can improve my chances of landing a job.

Background: Events have been added to the database.
The following events are scheduled:
Job Fair | 2/28/2015 12:00-4:00
Resume Workshop | 3/1/2015 1:00-3:00
Mock Interviews | 3/3/2015 12:00-6:00

Scenario: I want to view a recruiting event

Given I am on the home screen
When I follow "Job Fair"
Then I should see "Job Fair"
And I should see "2/28/2015 12:00-4:00"
And I should see button "View Details"
And I should see button "Register"

Scenario: I want to view a resume workshop
 
Given I am on the home screen
When I follow "Resume Workshop"
Then I should see "Resume Workshop"
And I should see "3/1/2015 1:00-3:00"
And I should see button "View Details"
And I should see button "Register"

Scenario: I want to register for a mock interview

Given I am on the home screen
When I follow "Mock Interviews"
Then I should see "Mock Interviews"
And I should see "3/3/2015 12:00-6:00"
And I should see button "View Details"
And I should see button "Register"
When I follow "Register"
Then I should see "Available Time Slots"
And I should see all available time slots
And I should see buttons "Register" for all available time slots
