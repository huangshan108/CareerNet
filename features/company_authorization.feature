 Feature: Company Authorization and Delegation

  As a company
  I want to have my account secured 
  so that other user can't change or see the status on my account

Background: Adding user to  database

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
    |huangshan108 |shuang@berkeley.edu |3            |

    Given the following companies exist
    | title          | brief       | website          | address |account_id |          
    | Google         | Search      | Google.com       |  Soda   |1          |

    And I am on the account_login page
    Then I enter "shuang@berkeley.edu" into "email" 
    And I enter "careernet" into "password" 
    And I press "Log In" button
    Then I should see "Welcome to CareerNet"

    Scenario: company can't edit and delete an event
      When I go to the events page
      And I try Add an event
      And I should see "You don't have the persmission to perform the action."
      When I go to the events page
      Then I should see "Resume Workshop"
      When I follow "Resume Workshop"
      And I should not see "Delete"

    Scenario: company can't visit or edit other student's profile
      Given I am on list students page
      When I try to edit view student C profile page
      And I should see "You don't have the persmission to perform the action."
      And I am on the main page

    Scenario: company can't view other students' application or company's applicant
      When I am on the main dashboard page
      When I try visit student C application page
      And I should see "You don't have the persmission to perform the action."
      And I am on the main page
      When I try visit random company application page
      And I should see "You don't have the persmission to perform the action."
      And I am on the main page


