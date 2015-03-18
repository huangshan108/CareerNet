Feature: Display upcoming jobs and events on main page

	As a student,
	I would like to see upcoming jobs and events
	So that I may apply to or attend them.

Background:

	Given the following events exist:
	| title 		      | description 	| 
	| Job Fair 		    | a	      	    |
	| Resume Workshop	| b		          |
	| Mock Interviews	| c		          |
	
	And the following jobs exist:
	| title			| description	|
	| Job1			| d		        |
	| Job2			| e 		      |
	| Job3			| f		        |

Scenario: I want to view an upcoming event
	
	Given I am on the main page
	Then I should see "Job Fair"
	When I follow "Job Fair"
	Then I should see "a"
	
Scenario: I want to view an upcoming job

	Given I am on the main page
	Then I should see "Job1"
	When I follow "Job1"
	Then I should see "d"
	
