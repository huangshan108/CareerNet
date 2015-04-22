Feature: Students can create and add more experiecne
    As a student, I want to add all my past experience so that companies or stuff can know me better when I submit an application

Background: Adding jobs to database
    
    Given the following accounts exist:
    |name         |email               |account_type |
    |huangshan108 |shuang@berkeley.edu |1            |

    Given the following students exist:
    | first_name   | last_name  | college_id   | major_id     | graduation_date   | resume_link |account_id |
    | Mark         | Sharp      | 1            | 1            | 2016-10-10        | example.com |1          |
  
    And I am on the account_login page
    Then I enter "shuang@berkeley.edu" into "email" 
    And I enter "careernet" into "password" 
    And I press "Log In" button
    Then I should see "Welcome to CareerNet"

    Scenario: Add past experience
        Given I am on student profile page
        When I follow "Edit profile"
        I should see button "+"
        When I follow the button "+"
        Then I should see "add more experience"
        Then I should see "Company Name"
        Then I should see "Location"
        Then I should see "Job title"
        And I should see "Salary"

    Scenario: Submit past experience
        When I fill "Company Name" with "Google"
        Then I fill "Location" with "Mountain View CA"
        And I fill "Job title" with "Software Engineering"
        And I fill "Salary" with "100000"
        When I go to student profile page
        And I should see "Google"
        And I should see "Mountain View CA"
        And I should see "Software Engineering"
        And I should see "100000"