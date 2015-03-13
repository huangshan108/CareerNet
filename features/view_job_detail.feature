Feature: View Job Detail

  As a student
  I want to click on job title to view job details
  so that I know if this Job fit me or not.

Background: Adding jobs to database

  Given the following jobs exist:
  | title                   | description | company    | salary |
  | Software Engineer       | Good        | Apple      | 100000 |
  | Data Scientist          | Great       | Intel      | 150000 |
  | Backend Developer       | Bad         | Microsoft  | 120000 |
  | Frontend Developer      | Average     | Facebook   | 200000 |

Scenario: View job details
  Given I am on the job 2 apply page
  Then I should see "Data Scientist"
  And I should see "Intel"
  And I should not see "Apple"
  And I should see "Apply"

