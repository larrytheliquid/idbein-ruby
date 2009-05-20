Feature: candidate creates a poll
  As a candidate
  I want to create a poll for an offer I have
  So that voters can elect me to send them a message
    Scenario: creating a valid poll
      Given I am logged in
      When I fill out and submit all required fields
      Then I should get redirected to the polls list
      And my poll should show up in the polls list