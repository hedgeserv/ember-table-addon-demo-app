Feature: Column groups reorder
  In order to summary related information of applying grids to finance concepts
  As a customer
  The columns should be grouped and releasable

  @complete
  Scenario: Dragging an inner column header should reorder that column within the group
    Given There are 200 sortable loans in chunk size 50
    When Presenting "column reorder"
    Then The index 1 should be "Id" column
    And Reorder an inner column "Id" header to "right" with 300 pixel
    Then The index 1 should be "Activity" column


  @complete
  Scenario: Dragging the column group header to neighbor of next should reorder with entire group
    Given There are 200 sortable loans in chunk size 50
    When Presenting "inner column sort"
    Then The index 1 should be "Group1" column
    And Reorder an inner column "Group1" header to "right" with 600 pixel
    Then The index 5 should be "Group1" column

  @complete
  Scenario: Dragging the column group header to neighbor should reorder with entire group
    Given There are 200 sortable loans in chunk size 50
    When Presenting "inner column sort"
    Then The index 1 should be "Group1" column
    And Reorder an inner column "Group1" header to "right" with 400 pixel
    Then The index 1 should be "Sector" column
    Then The index 2 should be "Group1" column