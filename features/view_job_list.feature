Feature: Open Job List

  As a student
  I want to view all available job listings
  so that I can see what jobs I can apply for.

Background: Adding jobs to database

  Given the following jobs exist:
  | title                   | description | company    | salary |
  | Software Engineer       | Good        | Apple      | 100000 |
  | Data Scientist          | Great       | Intel      | 150000 |
  | Backend Developer       | Bad         | Microsoft  | 120000 |
  | Frontend Developer      | Average     | Facebook   | 200000 |

Scenario: Go to jobs page
  Given I am on the jobs page
  Then I should see "Software Engineer"
  And I should see "Data Scientist"

Scenario: Sort jobs by title
  Given I am on the jobs page
  When I follow "Job"
  Then I should see "Backend Developer" before "Data Scientist"
  And I should see "Frontend Developer" before "Software Engineer"

Scenario: Sort jobs by Company
  Given I am on the jobs page
  When I follow "Company"
  Then I should see "Apple" before "Facebook"
  And I should see "Intel" before "Microsoft"