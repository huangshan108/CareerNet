Feature: Student Skills Feature
	As a student
	I want to be able to add my skills
	So that potential employers can know my strengths

Background: Adding jobs and com to database

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

  And I am on the account_login page
  Then I enter "shuang@berkeley.edu" into "email" and I enter "careernet" into "password" and I press "Log In" button
  Then I should see "Welcome to CareerNet"


Scenario: Click apply on jobs page.
 	Given I am on student profile page
    When I follow "Edit profile"
    Then I should be on edit profile page
    When I fill in Skills with "Python"
    And I press "Submit"
    Then I should see "Python"
    