Feature: Open Job List

  As a student
  I want to view all available job listings
  so that I can see what jobs I can apply for.

Background:Jobs have been added to database
 Given the following jobs exist:
 |title                                |  Company   |
 | Software Engineer                   |  Google    |       
 | Web designer                        |  Apple     |
 | Back-End developer                  |  FaceBook  |
 | Front-End developer                 |  Riot      |
 | Full Stack Engineer                 |   Amazon   |

Scenario: Go to jobs page
  Given I am on the homepage
  When I follow "Jobs"
  Then I should see "Software Engineering"
  And I should see "Web designer"

Scenario: Sort jobs by title
  Given I am on the jobs page
  When I follow "title"
  I should see "Back-End developer" before "Web Designer"
  And I should see "Front-End developer" before " Software Engineer"

Scenario: View job details
  Given I am on the jobs page
  When i follow "Software Engineer"
  Then I should be on the "Software Engineer" details page
  And I should see the company "Google"