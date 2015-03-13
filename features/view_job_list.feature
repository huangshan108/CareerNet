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
  |expired      |expired@berkeley.edu|2            |


Scenario: Go to jobs page
  I am on the CareerNet "/account/login" page
  Then I enter "shuang@berkeley.edu" into "email" and I enter "careernet" into "password" and I press "Log In" button
  Then I should see "Welcome to CareerNet"
  Given I am on the jobs page
  Then I should see "Software Engineer"
  And I should see "Data Scientist"

Scenario: Sort jobs by title
  I am on the CareerNet "/account/login" page
  Then I enter "shuang@berkeley.edu" into "email" and I enter "careernet" into "password" and I press "Log In" button
  Then I should see "Welcome to CareerNet"
  Given I am on the jobs page
  When I follow "Job"
  Then I should see "Backend Developer" before "Data Scientist"
  And I should see "Frontend Developer" before "Software Engineer"