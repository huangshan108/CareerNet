Feature: Company Post Job
  As a company
  I want to post the new job in jobs page
  so that I hire a candidate

Background: Adding jobs and com to database
  
   Given the following accounts exist:
  |name         |email               |account_type |
  |huangshan108 |shuang@berkeley.edu |3            |

  Given the following companies exist
  | title          | brief       | website          | address |account_id |          
  | Google         | Search      | Google.com       |  Soda   |1          |

  Given the following jobs exist:
  | title                   | description | company_id    | salary |
  | Software Engineer       | Good        | 1             | 100000 |

  And I am on the account_login page
  Then I enter "shuang@berkeley.edu" into "email" 
And I enter "careernet" into "password" 
And I press "Log In" button
  Then I should see "Welcome to CareerNet"

Scenario: Posting Jobs
  When I go to the main dashboard page
  And I follow "Post A New Job"
  Then I am on the job create page

Scenario: Creating Jobs
  Given I am on the job create page
  And I fill in "title" with "Software Engineering"
  And I fill in "description" with "Good"
  And I fill in "salary" with "77000"
  And I fill in "company_id" with "1"
  Then I press "Post"
  Then I should see "Software Engineering was successfully created"
  When I go to the main dashboard page
  And I follow "View Posted Jobs"
  Then I should see "Software Engineering"

Scenario: Deleting Jobs
  Given I am on the job 1 view page
  And I follow "Delete"
  Then I should see "The Job Software Engineer deleted."



