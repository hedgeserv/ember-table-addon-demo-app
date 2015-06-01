Feature: Column groups reorder
  In order to summary related information of applying grids to finance concepts
  As a customer
  The columns should be grouped and releasable

  @wip
  Scenario: Dragging an inner column header should reorder that column within the group
    Given There are 200 sortable loans in chunk size 50
    When Presenting "column reorder"
    Then The index 1 should be "Id" column
    And Reorder an inner column "Id" header to "right" with 300 pixel
    Then The index 1 should be "Activity" column