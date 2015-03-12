Feature: View Job Detail

  As a student
  I want to click on job title to view job details
  so that I know if this Job fit me or not.

Scenario: View job details
  Given I am on the apply page
  Then I should see job's "title"
  And I should see job's "company"
  And I should see job's "description"
  And I should see job's "salary"

Scenario: Apply the job
  When I am on the apply page
  And I should see the button "Apply"
