Feature: signing up for idbe.in
  As a visitor
  I want to signup
  So that I can log in

  Scenario: signing up
    Given I am not logged in
    When I go to the polls list
    And I try to signup
    And I submit all required user fields
    Then I should be redirected to the polls list
    And I should be logged in

