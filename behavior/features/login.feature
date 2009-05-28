Feature: User logs in
  As a user
  I want to log in
  So that I can create and vote on polls

  Scenario: Visitor is a user and enters valid credentials
    Given I have signed up
    When I go to the polls list
    And I try to login
    And I submit valid credentials
    Then I should be redirected to the polls list
    And I should be logged in

  Scenario: Visitor is not a user
    When I go to the polls list
    And I try to login
    And I submit fake credentials
    Then I should not be logged in

  Scenario: Logging out
    Given I have signed up
    And I am logged in
    When I go to the polls list
    And I try to logout
    Then I should not be logged in