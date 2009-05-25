Feature: signing up for idbe.in
  As a visitor
  I want to signup
  So that I can log in

  Scenario: signing up with valid information
    Given I am not logged in
    When I go to the polls list
    And I try to signup
    And I submit valid user data
    Then I should be redirected to the polls list
    And I should be logged in

  Scenario: signing up with invalid information
    Given I am not logged in
    When I go to the polls list
    And I try to signup
    And I submit invalid user data
    Then I should be shown validation errors
    And I should not be logged in