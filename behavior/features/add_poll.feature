Feature: Candidate adds a poll
  As a candidate
  I want to create a poll for an offer I have
  So that voters can elect me to send them a message

  Scenario: Valid information
    Given I have signed up
    And I am logged in
    When I go to the polls list
    And I try to add a new poll
    And I submit valid poll data
    Then I should be redirected to the polls list
    And my poll should be in the polls list

  Scenario: Invalid information
    Given I have signed up
    And I am logged in
    When I go to the polls list
    And I try to add a new poll
    And I submit invalid poll data
    Then I should be shown validation errors
    And my poll should not be in the polls list
