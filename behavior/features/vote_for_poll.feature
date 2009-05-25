Feature: Voter votes for a poll
  As a voter
  I want to vote for a poll
  So that I can receive an update from its candidate

  Scenario: Have voted for poll
    Given I am logged in
    And a candidate previously created a poll
    When I vote for the poll through the API
    And I go to the polls list
    Then the number of votes for it should be incremented

  Scenario: Have not voted for poll
    Given I am logged in
    And a candidate previously created a poll
    And I previously voted for the poll
    When I vote for the poll through the API
    And I go to the polls list
    Then the number of votes for it should not be incremented