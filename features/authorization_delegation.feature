Feature: Authorization and Delegation

  As a CareerNet_User
  I want to have my account secured 
  so that other user can't change or see the status on my account

Background: Adding user to  database

    Given the following jobs exist:
  	| title                   | description | company_id    | salary |
  	| Software Engineer       | Good        | 1             | 100000 |

    Given the following events exist:
    | title           | description   | 
    | Resume Workshop | b             |

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

    Scenario: student can't edit and delete an event
      When I go to the events page
      And I try Add an event
      And I should see "You don't have the persmission to perform the action."
      When I go to the events page
      Then I should see "Resume Workshop"
      When I follow "Resume Workshop"
      And I should not see "Delete"

    Scenario: student can't visit or edit other student's profile
      Given I am on list students page
      When I try to edit view student C profile page
      And I should see "You don't have the persmission to perform the action."
      And I am on the main page

    Scenario: student can't view other students' application or company's applicant
      When I am on the main dashboard page
      When I try visit student C application page
      And I should see "You don't have the persmission to perform the action."
      And I am on the main page
      When I try visit random company application page
      And I should see "You don't have the persmission to perform the action."
      And I am on the main page

    Scenario: student can't delete a job
      Given I am on the job 1 view page
      And I should not see "Delete"


    Scenario: student try to post a job
       When I am on the main dashboard page
       When I try vist post job page
       And I should see "You don't have the persmission to perform the action."
       And I am on the main page

