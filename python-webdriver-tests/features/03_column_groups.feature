Feature: Column groups
  In order to summary related information of applying grids to finance concepts
  As a customer
  The columns should be grouped

  @complete
  Scenario: styling for the entire group
    When Presenting "groups"
    Then The page should style for entire group, each column, first column and last column