Feature: Companies can create and/or modify profiles
    As a Company
    I want to update our profile
    So that students will better understand our Company when they apply for a job.

Background: Adding jobs/companies to database

  Given the following accounts exist:
  |name            |email                 |account_type |
  |huangshan108    |shuang@berkeley.edu   |1            |
  |Example Company |company@careernet.com |3            |

  Given the following companies exist:
  | title         | brief           | website            | address   | account_id |
  | Apple         | Hey             | apple.com          | Soda      | 1          |
  | Google        | Search          | google.com         | Soda      | 2          |

  Given the following students exist:
  |first_name         |last_name      |email               |account_id |
  |Shan               |Huang          |shuang@berkeley.edu |1          |

  Given the following jobs exist
  | title                   | description       | salary          | company_id |          
  | Director                | Frond-end         | 80000           |  1         |
  | Software Engineer       | Frond-end         | 120000          |  1         |
  | Engineering Manager     | Manager           | 200000          |  2         |

  Given the following applications exist
  | student_id     | job_id        |
  | 1              | 1             |

  And I am on the account_login page
  Then I enter "company@careernet.com" into "email" 
  And I enter "careernet" into "password" 
  And I press "Log In" button
  Then I should see "Welcome to CareerNet"
   
  Scenario: Edit company profile
    Given I am on company profile page
    When I follow "Edit profile"
    Then I should be on company edit profile page
    And I fill in Company Name with "Apple Inc"
    Then I fill in "city" with "San Francisco"
    And I press "Submit"
    Then I should see "Apple Inc"
    And I should see "San Francisco"

  Scenario: I should be able to see, on the company profile, the company's current job postings
    Given I am on company profile page
    Then I should see "Director"
    And I should see "Software Engineer"
    And I should not see "Engineering Manager"