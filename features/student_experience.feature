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
    When I click on add experience button
    When I fill in the following:
     | company_name| Riot                |
     | salary      | 70000               |
     | job_title   | Software Engineering|
    When I click on update button
    Then I am on student profile page
    And I should see "70000"
    And I should see "Software Engineering"
    When I follow "Delete"
    And I should not see "Riot"
    And I should not see "70000"

@javascript
Scenario: Adding a project

    Given I am on student profile page
    And I should see "Past Project"
    When I click on add project button
    When I fill in the following:
     | project_name | website     |
     | position     | full stack  |
     | description  | personal website |
     | start_date   | 07/03/2012|
     | end_date     | 07/03/2013|
    When I click on project update button
    Then I am on student profile page
    And I should see "website"
    And I should see "full stack "
    And I should see "personal website"
    When I follow "Delete"
    And I should not see "full stack"
    And I should not see "personal website"


@javascript
Scenario: Adding an past experience

    Given I am on student profile page
    And I should see "Past Education"
    When I click on add education button
    When I fill in the following:
     | school_name  | Berkeley     |
     | major        | EECS         |
     | start_date   | 07/03/2012|
     | graduation_date     | 07/03/2013|
    When I click on education update button



