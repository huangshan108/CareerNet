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

Scenario: Go to jobs page
  Given I am on the jobs page
  Then I should see "Software Engineer"
  And I should see "Data Scientist"

Scenario: Sort jobs by title
  Given I am on the jobs page
  When I follow "Job"
  Then I should see "Backend Developer" before "Data Scientist"
  And I should see "Frontend Developer" before "Software Engineer"