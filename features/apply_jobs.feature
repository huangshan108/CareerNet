Feature: Apply for jobs

  Apply The Job
  As a student
  I want to apply for jobs I am interested in.

Background: Adding jobs to database
  Given the following accounts exist:
  |name            |email                 |account_type |
  |huangshan108    |shuang@berkeley.edu   |1            |
  |Example Company |company@careernet.com |3            |

  Given the following students exist:
  |first_name         |last_name      |email               |account_id |
  |Shan               |Huang          |shuang@berkeley.edu |1          |
  
  Given the following companies exist
  | title          | brief       | website          | address |account_id |          
  | Google         | Search      | Google.com       |  Soda   |2          |

  Given the following jobs exist
  | title          | description       | salary          | company_id |          
  | Director       | Frond-end         | 80000           |  1         |

  And I am on the account_login page
  Then I enter "shuang@berkeley.edu" into "email" 
And I enter "careernet" into "password" 
And I press "Log In" button
  Then I should see "Welcome to CareerNet"

Scenario: Apply for jobs
  Given I am on the job 1 view page
	When I follow "Apply"
	Then I should see "Your application has been submitted!"
  When I am on the main dashboard page
  When I follow "View Applications"
  Then I should see "Director"
