Feature: Staff can create and/or modify profiles
    As a Staff Member
    I want to update our profile
    So that students can look up certain staff members if they need help

Background: Adding jobs to database

    Given the following schools exist:
    | school_name                   | school_type   | school_year  | address    |
    | Cambridge College-Portland    | public        | 4-year       | NONE       |

    Given the following majors exist:
    | name                            |
    | Humanities/Humanistic Studiesd  |
    
    Given the following accounts exist:
    |name         |email                    |account_type |
    |huangshan108 |shuang@berkeley.edu      |1            |
    |Alex         |alexstaff@berkeley.edu   |3            |

    Given the following students exist:
    | first_name   | last_name  | college_id   | major_id     | graduation_date   | resume_link |account_id |
    | Mark         | Sharp      | 1            | 1            | 2016-10-10        | example.com |1          |
  
    And I am on the account_login page
    Then I enter "alexstaff@berkeley.edu" into "email" 
    And I enter "alex" into "password" 
    And I press "Log In" button
    Then I should see "Welcome to CareerNet"

    Scenario: View staff profile
        Given I am on list staff page
        When I follow "More details"
        Then I should be on staff profile page
        And I should see "Alex"
   
    Scenario: Edit staff profile
        Given I am on staff profile page
        When I follow "Edit profile"
        Then I should be on edit profile page
        When I fill in First Name with "Steve"
        And I press "Submit"
        Then I should see "Steve"