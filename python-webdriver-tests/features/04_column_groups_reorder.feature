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
    And Reorder an inner column "Group1" header to "right" with 450 pixel
    Then The index 5 should be "Group1" column

  @complete
  Scenario: Dragging the column group header to neighbor should reorder with entire group
    Given There are 200 sortable loans in chunk size 50
    When Presenting "inner column sort"
    Then The index 1 should be "Group1" column
    And Reorder an inner column "Group1" header to "right" with 300 pixel
    Then The index 1 should be "Sector" column
    Then The index 2 should be "Group1" column

  @complete
  Scenario: Check reorder column indicator line before reorder
    Given There are 200 sortable loans in chunk size 50
    When Presenting "inner column sort"
    And Drag and hold column "Sector" to "right" with 1 pixel
    Then The reorder indicator line should be 598 from left

  @complete
  Scenario: Check reorder column indicator line after reorder
    Given There are 200 sortable loans in chunk size 50
    When Presenting "inner column sort"
    And Drag and hold column "Sector" to "right" with 300 pixel
    Then The reorder indicator line should be 898 from left

