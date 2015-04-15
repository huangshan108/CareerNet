Feature: Student search for jobs and events

    As a student, 
    I want to search for jobs and events,
    So that I can quickly find what I am looking for.

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

    Given the following events exist:
    | title           | description | time_start              | time_end                | location        |
    | Job Fair        | foo         | 2000-01-01 15:00:00 UTC | 2000-01-01 18:00:00 UTC | Anna Head       |
    | Resume Workshop | foo         | 2000-01-01 15:00:00 UTC | 2000-01-01 16:00:00 UTC | Gold Room       |
    | Mock Interviews | foo         | 2000-01-01 16:00:00 UTC | 2000-01-01 20:00:00 UTC | Wozniak Lounge  |


    And I am on the account login page
    Then I enter "shuang@berkeley.edu" into email
    And I enter "careernet" into "password"
    And I press "Log In" button
    Then I should see "Welcome to CareerNet"
    
Scenario: Search for jobs

    Given I am on the main dashboard page
    When I follow "Browse Jobs"
    And I enter "Google" into search
    And I press "Search" button
    Then I should see "Front-end"

Scenario: Search for events

    Given I am on the main dashboard page
    When I follow "Browse Events"
    And I enter "Job Fair" into search
    And I press "Search" button
    Then I should see "Anna Head"

