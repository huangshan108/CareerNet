Feature: Region Relation Vistualization

  As a staff
  I want to visualize the relation between location of jobs to students' salary
  So that I can serve the students better to get more attractive jobs

Background: Events have been added to the database.

  Given the following data exist:

  And I am on the account_login page
  Then I enter "careernet.staff+1@gmail.com" into "email" 
  And I enter "careernet" into "password" 
  And I press "Log In" button
  Then I should see "Welcome to CareerNet"


Scenario: Visit Region Relation Visualization

  Given I am on smart data report page
  And I press "Region Relation" button
  Then I should see a pie chart
  And I should see a table

Scenario: Visit Region Relation as a map
  Given I am on smart data report page
  And I press "Region Relation" button
  And I check "map" checkbox
  Then I should see a map of the U.S.
  And each state on map should be a shade corresponding to the amount of average salary of the students there
