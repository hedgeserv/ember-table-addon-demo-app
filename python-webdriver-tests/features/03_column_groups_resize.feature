Feature: Column groups resize
  In order to summary related information of applying grids to finance concepts
  As a customer
  The columns should be grouped and resizable

  @complete
  Scenario: styling for the entire group
    Given There are 300 loans in chunk size 50
    When Presenting "groups"
    Then The page should style for entire group, inner column, first column and last column


  @complete
  Scenario: Dragging the left column separator to left on grouped column should resize the neighboring column
    Given There are 200 loans in chunk size 50
    When Presenting "groups"
    And The user get the resize cursor in "Id" column
    When The user drags the "Id" on column to "left" with 50 pixel
    Then The "Id" column width should be 98 pixel
    And the "Group1" column width should be 299 pixel


  @complete
  Scenario: Dragging the left column separator to right on grouped column to should resize the neighboring column
    Given There are 200 loans in chunk size 50
    When Presenting "groups"
    And The user get the resize cursor in "Id" column
    When The user drags the "Id" on column to "right" with 50 pixel
    Then The "Id" column width should be 198 pixel
    And The "Group1" column width should be 299 pixel


  @complete
  Scenario: Dragging the right column separator to right on grouped column should resize the last inner column
    Given There are 200 loans in chunk size 50
    When Presenting "groups"
    And The user get the resize cursor in "status" column
    When The user drags the "status" on column to "right" with 50 pixel
    Then The "Id" column width should be 149 pixel
    And The "Group1" column width should be 348 pixel
    And The "Activity" column width should be 149 pixel
    And The "status" column width should be 198 pixel

  @complete
  Scenario: Dragging the right column separator to left on grouped column should resize the last inner column
    Given There are 200 loans in chunk size 50
    When Presenting "groups"
    And The user get the resize cursor in "status" column
    When The user drags the "status" on column to "left" with 50 pixel
    Then The "Id" column width should be 149 pixel
    And The "Group1" column width should be 248 pixel
    And The "Activity" column width should be 149 pixel
    And The "status" column width should be 98 pixel


  @complete
  Scenario: Dragging the column separator to right on any inner column should resize that column
    Given There are 200 loans in chunk size 50
    When Presenting "groups"
    And The user get the resize cursor in "Activity" column
    When The user drags the "Activity" on column to "right" with 50 pixel
    Then The "Id" column width should be 149 pixel
    And The "Group1" column width should be 348 pixel
    And The "Activity" column width should be 198 pixel
    And The "status" column width should be 149 pixel


  @complete
  Scenario: Dragging the column separator to left on any inner column should resize that column
    Given There are 200 loans in chunk size 50
    When Presenting "groups"
    And The user get the resize cursor in "Activity" column
    When The user drags the "Activity" on column to "left" with 50 pixel
    Then The "Id" column width should be 149 pixel
    And The "Group1" column width should be 248 pixel
    And The "Activity" column width should be 98 pixel
    And The "status" column width should be 149 pixel

  @complete
  Scenario: Dragging the last column separator of first grouped column to right
    Given There are 200 loans in chunk size 50
    When Presenting "groups"
    And The user get the resize cursor in "status" column
    When The user drags the "status" on column to "right" with 50 pixel
    Then The "Person" column width should be 449 pixel
    And The "Id" column width should be 149 pixel
    And The "Group1" column width should be 348 pixel
    And The "Activity" column width should be 149 pixel
    And The "status" column width should be 198 pixel
    And The "Name" column width should be 149 pixel
    And The "Use" column width should be 149 pixel
    And The "Sector" column width should be 149 pixel

  @complete
  Scenario: Dragging the first inner column of second grouped column to left
    Given There are 200 loans in chunk size 50
    When Presenting "groups"
    And The user get the resize cursor in "Name" column
    When The user drags the "Name" on column to "left" with 50 pixel
    Then The "Person" column width should be 398 pixel
    And The "Id" column width should be 149 pixel
    And The "Group1" column width should be 299 pixel
    And The "Activity" column width should be 149 pixel
    And The "status" column width should be 149 pixel
    And The "Name" column width should be 98 pixel
    And The "Use" column width should be 149 pixel
    And The "Sector" column width should be 149 pixel

  @complete
  Scenario: Dragging the second inner column of second grouped column to right
    Given There are 200 loans in chunk size 50
    When Presenting "groups"
    And The user get the resize cursor in "Use" column
    When The user drags the "Use" on column to "right" with 50 pixel
    Then The "Person" column width should be 498 pixel
    And The "Id" column width should be 149 pixel
    And The "Group1" column width should be 299 pixel
    And The "Activity" column width should be 149 pixel
    And The "status" column width should be 149 pixel
    And The "Name" column width should be 149 pixel
    And The "Use" column width should be 198 pixel
    And The "Sector" column width should be 149 pixel

  @complete
  Scenario: Dragging the last inner column of second grouped column to left
    Given There are 200 loans in chunk size 50
    When Presenting "groups"
    And The user get the resize cursor in "Sector" column
    When The user drags the "Sector" on column to "left" with 50 pixel
    Then The "Person" column width should be 398 pixel
    And The "Id" column width should be 149 pixel
    And The "Group1" column width should be 299 pixel
    And The "Activity" column width should be 149 pixel
    And The "status" column width should be 149 pixel
    And The "Name" column width should be 149 pixel
    And The "Use" column width should be 149 pixel
    And The "Sector" column width should be 98 pixel
