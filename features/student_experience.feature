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

    Given the following work experience exists:
    |Title      |Employer   |Salary     |student_id|
    |Engineer   |Apple      |100000     |1         |

    Scenario: Adding a experience
    Given I am on edit student profile page
    And I add a new "Work Experience"
    Then I enter "Software Engineer" into "Title"
    And I enter "Apple" into "Employer"
    And I enter "120000" into "Salary"
    And I press "Save" button
    Then I should see my "Apple Work Experience" displayed

    Scenario: Adding a different experience
    Given I am on edit student profile page
    And I add a new "Project Experience"
    Then I enter "CareerNet" into "Project Title"
    And I enter "Backend Developer" into "Role"
    And I press "Save Button"
    Then I should see my "CareerNet Project Experience" displayed

    Scenario: Deleting an experience
    Given I am on edit student profile page
    And I delete my "Apple Work Experience"
    Then my "Apple Work Experience" is no longer displayed