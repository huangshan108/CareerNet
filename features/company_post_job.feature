Feature: Company Post Job
  As a company
  I want to post the new job in jobs page
  so that I hire a candidate

Background: Adding jobs and com to database

  Given the following companies exist:
  | name   |          
  | Google |
  
  Given the following jobs exist:
  | title                   | description | company_id    | salary |
  | Software Engineer       | Good        | 1             | 100000 |
  
   Given the following accounts exist:
  |name         |email               |account_type |
  |huangshan108 |shuang@berkeley.edu |3            |
  |expired      |expired@berkeley.edu|2            |

  And I am on the account_login page
  Then I enter "shuang@berkeley.edu" into "email" and I enter "careernet" into "password" and I press "Log In" button
  Then I should see "Welcome to CareerNet"

Scenario: Posting Jobs
  When I go to the main page
  And I press "Post a New Job"
  Then I am on the job create page

Scenario: Creating Jobs
  Given I am on the job create page
  And I fill in "title" with "Software Engineering"
  And I fill in "description" with "Good"
  And I fill in "salary" with "10000"
  And I fill in "company_id" with "2"
  Then I press "Post the Job"
  Then I should see "Software Engineering was successfully created"

Scenario: Deleting Jobs
  Given I am on the job 1 apply page
  And I press "Delete the Job"
  Then I should see "The Job Software Engineer deleted."

