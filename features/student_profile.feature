Feature: Students can create and/or modify profiles
    As a student, I want to update my profiles so that companies can know me better when I submit an application

Background: Adding jobs to database

    Given the following students exist:
    | first_name   | last_name  | college_id   | major_id     | graduation_date   | resume_link |
    | Mark         | Sharp      | 1            | 1            | 2016-10-10        | example.com |

    Given the following schools exist:
    | school_name                   | school_type   | school_year  | address    |
    | Cambridge College-Portland    | public        | 4-year       | NONE       |

    Given the following majors exist:
    | name                            |
    | Humanities/Humanistic Studiesd  |
    
    Given the following accounts exist:
    |name         |email               |account_type |
    |huangshan108 |shuang@berkeley.edu |1            |
    |expired      |expired@berkeley.edu|2            |
  
    Scenario: Go to students page
        I am on the CareerNet "/account/login" page
        And I log in
        Given I am on list students page
        Then I should see "Mark Sharp"
        Then I should see "Humanities/Humanistic Studiesd"
        Then I should see "More details"

    Scenario: View student profile
        I am on the CareerNet "/account/login" page
        And I log in
        Given I am on list students page
        When I follow "More details"
        Then I should be on student profile page
        And I should see "Mark Sharp"
   
    Scenario: Edit student profile
        I am on the CareerNet "/account/login" page
        And I log in
        Given I am on student profile page
        When I follow "Edit profile"
        Then I should be on edit profile page
        When I fill in First Name with "Amy"
        And I press "Submit"
        Then I should see "Amy"

    Scenario: View university profile
        I am on the CareerNet "/account/login" page
        And I log in
        Given I am on student profile page
        When I follow "Cambridge College-Portland"
        Then I should be on school profile page
        And I should see "4-year"