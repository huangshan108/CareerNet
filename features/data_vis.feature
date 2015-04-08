Feature: Data visualization

    As a staff
    I want to visualize the data we have collected
    So that I can learn more about career management

    Scenario: Pie charts of student demographic
        When I am on the data visualization page
        I should see these pie charts of student demographic:
        F v. M
        Intl v. U.S.
        Years of experience
        Undergraduate Majors

    Scenario: Organization tab
        When I am on the data visualization page
        And I click on "Organization" tab
        I should see a bar chart of top 10 organizations in graduate number
