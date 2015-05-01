Feature: Authorization and Delegation

  As a CareerNet_User
  I want to have my account secured 
  so that other user can't change or see the status on my account

Background: Adding user to  database

    Given the following companies exist
    | title          | brief       | website          | address |account_id |          
    | Google         | Search      | Google.com       |  Soda   |1          |

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
