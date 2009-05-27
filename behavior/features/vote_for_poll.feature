Feature: Voter votes for a poll
  As a voter
  I want to vote for a poll
  So that I can receive an update from its candidate

  Scenario: Viewing a poll I have not voted for
    Given I am logged in
    And a candidate previously created a poll
    When I go to the polls list
    Then there should be a not-voted icon
    And the number of votes for it should be 0

  Scenario: Voting for a poll I have not voted for yet with persistence
    Given I am logged in
    And a candidate previously created a poll
    When I go to the polls list
    And I vote for the poll
    And I go to the polls list
    Then there should be a voted icon
    And the number of votes for it should be 1

  Scenario: Voting for a poll I have already voted for
    Given I am logged in
    And a candidate previously created a poll
    And I previously voted for the poll
    When I go to the polls list
    And I vote for the poll
    And I go to the polls list
    Then there should be a voted icon
    And the number of votes for it should be 1