Feature: Viewing my polls
  As a candidate
  I want to view the polls I have created
  So that I can send a message to voters of polls that have met their threshold

  Scenario: Viewing my polls
    Given I have signed up
    And I am logged in
    And I previously created a poll
    And a candidate previously created a poll
    When I go to the polls list
    And I try to view my polls
    Then my poll should be listed
    And another candidate's poll should not be listed