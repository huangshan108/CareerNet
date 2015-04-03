Feature: Student Skills Feature
  As a student
  I want to be able to add my skills
  So that potential employers can know my strengths

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
    
    Given the following skills exist:
    |name         |skill_id|
    |Python       |1       |



    And I am on the account_login page
    Then I enter "shuang@berkeley.edu" into "email" and I enter "careernet" into "password" and I press "Log In" button
    Then I should see "Welcome to CareerNet"

    Scenario: Adding an existing skill
      Given I am on student profile page
      When I follow "Edit profile"
      When I fill in "add_skill_name" with "Python"
      And I press "Submit"
      Then I should see "Python"

    Scenario: Adding a new skill
      Given I am on student profile page
      When I follow "Edit profile"
      When I fill in "add_skill_name" with "Best Skill NA"
      And I press "Submit"
      Then I should see "Best Skill NA"

    Scenario: Added a skill that's already added
      Given I am on student profile page
      When I follow "Edit profile"
      When I fill in "add_skill_name" with "Best Skill NA"
      And I press "Submit"
      When I follow "Edit profile"
      When I fill in "add_skill_name" with "Best Skill NA"
      And I press "Submit"
      Then I should see "Best Skill NA"

    Scenario: Deleting a skill
      Given I am on student profile page
      When I follow "Edit profile"
      When I fill in "add_skill_name" with "Python"
      And I press "Submit"
      When I follow "Edit profile"
      When I fill in "remove_skill_name" with "Python"
      And I press "Submit"
      Then I should not see "Python"
