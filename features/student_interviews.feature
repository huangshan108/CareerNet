Feature: Interview scheduling and management for students

    As a student,
    I want to see, consider, and schedule offered interviews,
    So that I can interview with companies.

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
    Then I enter "shuang@berkeley.edu" into email
    And I enter "careernet" into "password"
    And I press "Log In" button
    Then I should see "Welcome to CareerNet"

    Given I am on the job 1 view page
    When I follow "Apply"
    Then I should see "You application has been submitted!"
    When I am on the main dashboard page
    When I follow "View Applications"
    Then I should see "Director"
    
Scenario: Accept interview time with company
    
    Given I am on the main dashboard page
    When I follow "View Applications"
    Then I should see "Director"
    When I follow "Schedule interview"
    Then I should see "Confirm interview time"

Scenario: View upcoming interviews

    Given I am on the main dashboard page
    When I follow "View Applications"
    Then I should see "Director"
    When I follow "Schedule interview"
    Then I should see "Confirm interview time"
    When I press "Confirm interview time"
    And I am on the main dashboard page
    And I follow "View Interviews"
    Then I should see "Director"
    And I should see "Time"
    And I should see "Cancel"
    When I press "Cancel"
    Then I should not see "Director"


