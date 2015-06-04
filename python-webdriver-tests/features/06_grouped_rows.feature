Feature: Indicators for expanding and collapsing grouped rows
  In order to manage the parent/child relationships of large data sets
  As a user presented with a grid
  I need an intuitive set of controls

  @wip
  Scenario: Grouping column is presented as first column
    Given I have grouped loans
    When Presenting "grouping column"
    Then There are 3 columns
    And The 2 column is "First"
    And The 3 column is "Second"

  @wip
  Scenario: Grouped rows are presented
    Given I have the following grouped loans in MounteBank:
      | group_name | first | second |
      | group1     | f-1   | s-1    |
      | group2     | f-2   | s-2    |
      | group3     | f-3   | s-3    |
      | group4     | f-4   | s-4    |
      | group4     | f-5   | s-5    |
    When Presenting "grouping column present grouped loans"
    Then I see grouped rows:
      | indicator | group_name | first | second |
      | +         | group1     | f-1   | s-1    |
      | +         | group2     | f-2   | s-2    |
      | +         | group3     | f-3   | s-3    |
      | +         | group4     | f-4   | s-4    |
      | +         | group4     | f-5   | s-5    |

  @wip
  Scenario: Default expansion indicator with fully loaded data
    Given There are 50 grouped loans
    When Presenting "grouping column"
    Then The row "row_parent" indicator should be "expand"
    When Click "expand" for row "row_parent"
    Then The row "row_parent" indicator should be "collapse"