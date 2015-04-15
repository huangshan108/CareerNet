Feature: Interview scheduling and management for companies

    As a company,
    We want to see and offer interviews,
    So that we can interview students.

Background:
    
    Given the following accounts exist:
    | name         | email                 | account_type |
    | huangshan108 | shuang@berkeley.edu   | 1            |
    | company1     | company@careernet.com | 3            |
    
    Given the following students exist:
    | first_name   | last_name       | email               | account_id |
    | Shan         | Huang           | shuang@berkeley.edu | 1          |
    
    Given the following companies exist:
    | title         | brief           | website            | address   | account_id |
    | Google        | Search          | google.com         | Soda      | 2          |

    Given the following jobs exist:
    | title         | description      | salary            | company_id  |
    | Director      | Front-end        | 80000             | 1           |

    And I am on the account login page
    Then I enter "company@careernet.com" into email
    And I enter "careernet" into "password"
    And I press "Log In" button
    Then I should see "Welcome to CareerNet"
    
Scenario: Offer interview

    Given I am on the main dashboard page
    When I follow "View Applications"
    Then I should see "Director"
    When I follow "Director"
    Then I should see "Shan Huang"
    When I follow "Offer interview"
    And I fill in "time" with "2015-05-01 15:00:00 UTC"
    And I fill in "location" with "Soda"
    And I press "Submit"
    Then I am on the view applications page
    Given I am on the main dashboard page
    When I follow "View Interviews"
    Then I should see "Director"

Scenario: View offered interviews
    
    Given I am on the main dashboard page
    When I follow "View Interviews"
    Then I should see "Director"
    And I should see "Time"
    And I should see "Location"
    And I should see "Cancel"
    When I press "Cancel"
    Then I should not see "Director"

