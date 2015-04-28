Feature: Students can add experiences to their profile
    As a student
    I want to add experiences to my profile
    So that companies can better know who I am.

Background: Adding jobs to database

    Given the following schools exist:
    | school_name                   | school_type   | school_year  | address    |
    | Cambridge College-Portland    | public        | 4-year       | NONE       |

    Given the following majors exist:
    | name                            |
    | Humanities/Humanistic Studiesd  |
    
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

    @javascript
    Scenario: Adding a experience
    Given I am on student profile page
    And I should see "Past Experience"
    When I press "+"
    Then I should see "Add experience"
    And I should see "update"
    When I fill in the following:
     | company_name| Riot       |
     | salary      | 70000      |
     | location    | Berkeley   |
     | description | Full stack |
     | job         | Software Engineering|
    When I press "Update"
    Then I am on student profile page
    And I should see "Riot"
    And I should see "70000"
    And I should see "Berkeley"
    And I should see "Software Engineering"

