Feature: Column groups
  In order to summary related information of applying grids to finance concepts
  As a customer
  The columns should be grouped

  @complete
  Scenario: styling for the entire group
    Given There are 300 loans in chunk size 50
    When Presenting "groups"
    Then The page should style for entire group, inner column, first column and last column

  @complete
  Scenario: Dragging the left column separator to left on grouped column should resize the neighboring column
    Given There are 200 loans in chunk size 50
    When Presenting "groups"
    And The user should get the resize cursor in "left column separator"
    When User drags the "left column separator" on a grouped column with 50 pixel to "left"


  @complete
  Scenario: Dragging the left column separator to right on grouped column to should resize the neighboring column
    Given There are 200 loans in chunk size 50
    When Presenting "groups"
    And The user should get the resize cursor in "left column separator"
    When User drags the "left column separator" on a grouped column with 50 pixel to "right"

  @complete
  Scenario: Dragging the right column separator to right on grouped column should resize the last inner column
    Given There are 200 loans in chunk size 50
    When Presenting "groups"
    Then The user should get the resize cursor in "right column separator"
    Then User drags the "right column separator" on a grouped column with 50 pixel to "right"

  @complete
  Scenario: Dragging the right column separator to left on grouped column should resize the last inner column
    Given There are 200 loans in chunk size 50
    When Presenting "groups"
    Then The user should get the resize cursor in "right column separator"
    Then User drags the "right column separator" on a grouped column with 50 pixel to "left"

  @complete
  Scenario: Dragging the column separator to right on any inner column should resize that column
    Given There are 200 loans in chunk size 50
    When Presenting "groups"
    Then The user should get the resize cursor in "inner column separator"
    Then User drags the "inner column separator" on a grouped column with 50 pixel to "right"

  @complete
  Scenario: Dragging the column separator to left on any inner column should resize that column
    Given There are 200 loans in chunk size 50
    When Presenting "groups"
    Then The user should get the resize cursor in "inner column separator"
    Then User drags the "inner column separator" on a grouped column with 50 pixel to "left"