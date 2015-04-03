Feature: Company view jobs

  As a company
  I want to view applications.

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

  Given the following applications exist
  | student_id     | job_id        |
  | 1              | 1             |

  And I am on the account_login page
  Then I enter "company@careernet.com" into "email" 
  And I enter "careernet" into "password" 
  And I press "Log In" button
  Then I should see "Welcome to CareerNet"

Scenario: Company view applied jobs
	When I follow "View Applications"
	Then I should see "Director"