Feature: View all my upcoming events on a single calendar page
    As a student, I want to see all my future interviews, workshops, appointments on the calendar, the ones I already signed up for and the one available for me to sign up will be shown in different colors. And I should be able to filter and only see part of them based on cetagory. Also, when I click on them, I could either perform signup/cancel actions or be brought to the right page to continue performing proper actions.

Background: Adding information to database

    Given the following accounts exist:
    |name            |email                 |account_type |
    |huangshan108    |shuang@berkeley.edu   |1            |
    |Example Company |company@careernet.com |3            |

    Given the following students exist:
    | first_name   | last_name  | college_id   | major_id     | graduation_date   | resume_link |account_id |
    | Mark         | Sharp      | 1            | 1            | 2016-10-10        | example.com |1          |

    Given the following staffs exist:
    |first_name         |last_name      |email               |account_id |
    |Fake               |Staff          |staff1@berkeley.edu |2          |

    Given the following companies exist
    | title          | brief       | website          | address |account_id |          
    | Google         | Search      | Google.com       |  Soda   |2          |

    Given the following appointments exist:
    | time_slot    | staff       | student      |
    | 2            | 1           | 1            |
    | 3            | 1           | 3            |

    Given the following jobs exist
    | title          | description       | salary          | company_id |          
    | Director       | Frond-end         | 80000           |  1         |


Scenario: I should see the event on calendar after posting a new event

    Given I am on the events page
    Then I should not see "Tech Talk"
    When I follow "Create New Event"
    And I enter "Tech Talk" into "title"
    And I press "Create"
    Then I am on the calendar page
    And I should see "Tech Talk"
    When I follow "Tech Talk"
    And I should be on the event page

Scenario: I should be able to delete an event on calendar
  
    Given I am on the calendar page
    Then I should see "Resume Workshop"
    When I follow "Resume Workshop"
    And I press "Yes" on the confirmation prompt
    Then I am on the events page
    And I should not see "Resume Workshop"
    When I am on the calendar page
    And I should not see "Resume Workshop"

Scenario: I should see interviews on my calendar
    Given I am on the job 1 view page
    When I follow "Apply"
    Then I should see "You application has been submitted!"
    When I am on the main dashboard page
    When I follow "View Applications"
    Then I should see "Director"

Scenario: I should see my appointments on my calendar

    Given I am on the appointments page
    When I follow "Make a new appointment"
    And I should see Fake Staff
    When I follow "Book"
    And I am on the calendar page
    Then I should see Fake Staff