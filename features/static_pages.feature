Feature: Static pages
    Should open static pages
 
    Scenario: Opens home page
        Given I am on the "/" page
        Then I should see "Home page"