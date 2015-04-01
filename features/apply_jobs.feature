Feature: Apply The Job
As a student
I want to apply for jobs I am interested in.

Background: Adding jobs to database

  Given the following comapny exist:
  | title          | description       | salary          | company_id |          
  | Engineer       | Frond-end     		 | 80000           |  1			    |
  
  Given the following comapny exist:
  | title          | brief       | website          | address |          
  | Google         | Search      | Google.com       |  Soda   |
  
   Given the following accounts exist:
  |name         |email               |account_type |
  |huangshan108 |shuang@berkeley.edu |1            |
  |expired      |expired@berkeley.edu|2            |

  And I am on the account_login page
  Then I enter "shuang@berkeley.edu" into "email" and I enter "careernet" into "password" and I press "Log In" button
  Then I should see "Welcome to CareerNet"

Scenario: Apply for jobs
	I am on the job detail page with job id "1"
	When I click "Apply" button
	Then I should see "you have successfully applied for this position".

Scenario: Student view applied jobs
	I am on the "main page" for student
	When I press "View Applied Jobs"
	I should see "Engineer" and "Google" and "Applied"

Scenario: Company view applied jobs
	I am ont the "main page" for companies
	When I press "View Applications"
	I should see "Shan Hunag" and "Front-end" and "Applied"