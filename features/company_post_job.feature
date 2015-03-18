As a company
I want to post the new job in jobs page
so that I hire a candidate

Background: Adding jobs and com to database

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

Scenario: Posting Jobs
  Given I am on the main page
  And I press "Post a new Job" button
  And I should on job create page

Scenario: Creating Jobs
  Given I am on the job create page
  And I fill in "Job title" with "Software Engineering"
  And I fill in "Job description" with "Good"
  And I fill in "Job salary "with "100000$"
  And I fill in "company name" with "Google"
  Then I press "Post " button
  Then I should be redirect to "Jobs Page"
  And I should be able to see "Software" on "Jobs Page"
