@f
Feature: Viewing poll details
  As a voter
  I want to view a polls details
  So that I can decide whether or not to vote for it

  Scenario: Viewing a poll
    Given a candidate previously created a poll
    When I go to the polls list
    And I try to view a poll's details
    Then the poll's title should be displayed
    And the poll's description should be displayed