Feature: Companies can create and/or modify profiles
    As a Company
    I want to update our profile
    So that students will better understand our Company when they apply for a job.

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
    |Apple        |support@apple.com   |2            |

    Given the following students exist:
    | first_name   | last_name  | college_id   | major_id     | graduation_date   | resume_link |account_id |
    | Mark         | Sharp      | 1            | 1            | 2016-10-10        | example.com |1          |
  
    And I am on the account_login page
    Then I enter "support@apple.com" into "email" 
    And I enter "apple" into "password" 
    And I press "Log In" button
    Then I should see "Welcome to CareerNet"

    Scenario: View company profile
        Given I am on list company page
        When I follow "More details"
        Then I should be on company profile page
        And I should see "Apple"
   
    Scenario: Edit company profile
        Given I am on company profile page
        When I follow "Edit profile"
        Then I should be on edit profile page
        When I fill in Company Name with "Apple Inc"
        And I press "Submit"
        Then I should see "Apple Inc"