Feature: candidate creates a poll
  As a candidate
  I want to create a poll for an offer I have
  So that voters can elect me to send them a message

  Scenario: creating a valid poll
    Given I am logged in
    When I go to the polls list
    And I try to add a new poll
    And I fill out and submit all required fields
    Then my poll should show up in the polls list