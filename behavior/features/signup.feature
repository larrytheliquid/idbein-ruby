Feature: Visitor signs up
  As a visitor
  I want to sign up
  So that I can log in

  Scenario: Valid information
    Given I am not logged in
    When I go to the polls list
    And I try to sign up
    And I submit valid user data
    Then I should be redirected to the polls list
    And I should be logged in

  Scenario: Invalid information
    Given I am not logged in
    When I go to the polls list
    And I try to sign up
    And I submit invalid user data
    Then I should be shown validation errors
    And I should not be logged in