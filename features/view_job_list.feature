Feature: Open Job List

  As a student
  I want to view all available job listings
  so that I can see what jobs I can apply for.

Background: Adding jobs to database

  Given the following jobs exist:
  | title                   | description | company_id    | salary |
  | Software Engineer       | Good        | 1          | 100000 |
  | Data Scientist          | Great       | 2          | 150000 |
  | Backend Developer       | Bad         | 3          | 120000 |
  | Frontend Developer      | Average     | 4          | 200000 |

  Given the following companies exist:
  | name          | 
  | Apple         | 
  | Intel         |
  | Microsoft     |
  | Facebook      |

  Given the following accounts exist:
  |name         |email               |account_type |
  |huangshan108 |shuang@berkeley.edu |1            |

  Given the following students exist:
  |first_name         |last_name      |email               |account_id |
  |Shan               |Huang          |shuang@berkeley.edu |1          |

  And I am on the account_login page
  Then I enter "shuang@berkeley.edu" into "email" 
And I enter "careernet" into "password" 
And I press "Log In" button
  Then I should see "Welcome to CareerNet"

Scenario: Go to jobs page
  Given I am on the jobs page
  Then I should see "Software Engineer"
  And I should see "Data Scientist"