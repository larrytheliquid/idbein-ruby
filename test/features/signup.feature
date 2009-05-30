Feature: Visitor signs up
  As a visitor
  I want to sign up
  So that I can log in

  Scenario: Valid information
    When I go to the polls list
    And I try to sign up
    And I submit valid account info
    Then I should be redirected to the polls list
    And I should be logged in

  Scenario: Invalid information
    When I go to the polls list
    And I try to sign up
    And I submit invalid account info
    Then I should be shown validation errors
    And I should not be logged in