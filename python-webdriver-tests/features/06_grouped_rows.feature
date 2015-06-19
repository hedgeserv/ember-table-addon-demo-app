Feature: Indicators for expanding and collapsing grouped rows
  In order to manage the parent/child relationships of large data sets
  As a user presented with a grid
  I need an intuitive set of controls

  @complete
  Scenario: Grouping column is presented as first column
    Given There are 5 grouped loans
    When Presenting "grouping column"
    Then There are 4 columns
    And The index 1 should be "Id" column
    And The index 2 should be "Activity" column
    And The index 3 should be "status" column
    And The index 0 should be "GroupingColumn" column

  @complete
  Scenario: Grouped rows are presented
    Given I have the following grouped loans in MounteBank:
      | groupName | id | activity | isGroupRow |
      | group1    | f1 | s1       | True       |
      | group2    | f2 | s2       | True       |
      | group3    | f3 | s3       | True       |
      | group4    | f4 | s4       | True       |
      | group5    | f5 | s5       | True       |
    When Presenting "grouping column"
    Then I see grouped rows:
      | indicator | groupName | Id | Activity |
      | +         | group1    | f1 | s1       |
      | +         | group2    | f2 | s2       |
      | +         | group3    | f3 | s3       |
      | +         | group4    | f4 | s4       |
      | +         | group5    | f5 | s5       |

  @complete
  Scenario: The grouping column should not be scrolled
    Given There are 5 grouped loans
    When Presenting "grouping column"
    And The user drags the "status" on column to "right" with 1000 pixel
    And Drag horizontal scroll bar with 1000 pixel
    Then The column header block should has "scroll left" and same as body scroll left
    And The grouping and fixed columns should not be scrolled


  @complete
  Scenario: check grouped rows with collapse indicator
    Given I have the following grouped loans in MounteBank:
      | groupName   | id   | activity | isGroupRow |
      | group1      | f1   | s1       | True       |
      | group1-chd1 | f1-1 | s1-1     | False      |
      | group1-chd2 | f1-2 | s1-2     | False      |
      | group2      | f2   | s2       | True       |
      | group3      | f3   | s3       | True       |
      | group3-chd1 | f3-1 | s3-1     | False      |
      | group3-chd2 | f3-2 | s3-2     | False      |
      | group4      | f4   | s4       | True       |
      | group5      | f5   | s5       | True       |
    When Presenting "grouping column"
    And Click "expand" for row "group1"
    And Click "expand" for row "group3"
    Then I see grouped rows:
      | indicator | groupName   | Id   | Activity |
      | -         | group1      | f1   | s1       |
      |           | group1-chd1 | f1-1 | s1-1     |
      |           | group1-chd2 | f1-2 | s1-2     |
      | +         | group2      | f2   | s2       |
      | -         | group3      | f3   | s3       |
      |           | group3-chd1 | f3-1 | s3-1     |
      |           | group3-chd2 | f3-2 | s3-2     |
      | +         | group4      | f4   | s4       |
      | +         | group5      | f5   | s5       |
    When Click "collapse" for row "group1"
    Then I see grouped rows:
      | indicator | groupName   | Id   | Activity |
      | +         | group1      | f1   | s1       |
      | +         | group2      | f2   | s2       |
      | -         | group3      | f3   | s3       |
      |           | group3-chd1 | f3-1 | s3-1     |
      |           | group3-chd2 | f3-2 | s3-2     |
      | +         | group4      | f4   | s4       |
      | +         | group5      | f5   | s5       |


  @wip
  Scenario: Expand grouped row with partial loaded children loans
    Given I have the following grouped loans in MounteBank:
      | groupName | first | second |
      | group1    | f1    | s1     |
      | group2    | f2    | s2     |
      | group3    | f3    | s3     |
      | group4    | f4    | s4     |
      | group5    | f5    | s5     |
    When Presenting "grouping column present partial loaded children"
    And The row "group1" indicator should be "expand"
    Then There should be 2 sections loaded
    When Customer drags scroll bar by offset 60 with 1 times
    Then There should be 3 sections loaded

  @complete
  Scenario: Expand and collapse grouped rows with unlimited level
    Given I have the following grouped loans in MounteBank:
      | groupName        | id     | activity | isGroupRow |
      | group1           | f1     | s1       | True       |
      | group1-chd1      | f1-1   | s1-1     | True       |
      | group1-chd1-chd1 | f1-1-1 | s1-1-1   | False      |
      | group1-chd1-chd2 | f1-1-2 | s1-1-2   | False      |
      | group1-chd2      | f1-2   | s1-2     | True       |
      | group1-chd2-chd1 | f1-2-1 | s1-2-1   | False      |
      | group1-chd2-chd2 | f1-2-2 | s1-2-2   | False      |
      | group2           | f2     | s2       | True       |
      | group2-chd1      | f2-1   | s2-1     | True       |
      | group2-chd1-chd1 | f2-1-1 | s2-1-1   | False      |
      | group2-chd1-chd2 | f2-1-2 | s2-1-2   | False      |
      | group2-chd2      | f2-2   | s2-2     | True       |
      | group2-chd2-chd1 | f2-2-1 | s2-2-1   | False      |
      | group2-chd2-chd2 | f2-2-2 | s2-2-2   | False      |
    When Presenting "grouping column"
    Then I see grouped rows:
      | indicator | groupName | Id | Activity |
      | +         | group1    | f1 | s1       |
      | +         | group2    | f2 | s2       |
    And Click "expand" for row "group1"
    And Click "expand" for row "group1-chd1"
    And Click "expand" for row "group1-chd2"
    Then I see grouped rows:
      | indicator | groupName        | Id     | Activity |
      | -         | group1           | f1     | s1       |
      | -         | group1-chd1      | f1-1   | s1-1     |
      |           | group1-chd1-chd1 | f1-1-1 | s1-1-1   |
      |           | group1-chd1-chd2 | f1-1-2 | s1-1-2   |
      | -         | group1-chd2      | f1-2   | s1-2     |
      |           | group1-chd2-chd1 | f1-2-1 | s1-2-1   |
      |           | group1-chd2-chd2 | f1-2-2 | s1-2-2   |
      | +         | group2           | f2     | s2       |
    When Click "collapse" for row "group1"
    Then I see grouped rows:
      | indicator | groupName | Id | Activity |
      | +         | group1    | f1 | s1       |
      | +         | group2    | f2 | s2       |
    When Click "expand" for row "group1"
    Then I see grouped rows:
      | indicator | groupName        | Id     | Activity |
      | -         | group1           | f1     | s1       |
      | -         | group1-chd1      | f1-1   | s1-1     |
      |           | group1-chd1-chd1 | f1-1-1 | s1-1-1   |
      |           | group1-chd1-chd2 | f1-1-2 | s1-1-2   |
      | -         | group1-chd2      | f1-2   | s1-2     |
      |           | group1-chd2-chd1 | f1-2-1 | s1-2-1   |
      |           | group1-chd2-chd2 | f1-2-2 | s1-2-2   |
      | +         | group2           | f2     | s2       |

  @complete
  Scenario: The expand and collapse indicator should be pluggable
    Given I have the following grouped loans in MounteBank:
      | groupName   | id   | activity | isGroupRow |
      | group1      | f1   | s1       | True       |
      | group1-chd1 | f1-1 | s1-1     | False      |
      | group1-chd2 | f1-2 | s1-2     | False      |
      | group2      | f2   | s2       | True       |
      | group3      | f3   | s3       | True       |
      | group3-chd1 | f3-1 | s3-1     | False      |
      | group3-chd2 | f3-2 | s3-2     | False      |
      | group4      | f4   | s4       | True       |
      | group5      | f5   | s5       | True       |
    When Presenting "grouping column with pluggable indicator"
    Then The row "group1" indicator should be "expand" with customized
    When When Click "expand" for row "group1"
    Then The row "group1" indicator should be "collapse" with customized


  @complete
  Scenario: The grouping column should be auto resize
    Given I have the following grouped loans in MounteBank:
      | groupName        | id     | activity | isGroupRow |
      | group1           | f1     | s1       | True       |
      | group1-chd1      | f1-1   | s1-1     | True       |
      | group1-chd1-chd1 | f1-1-1 | s1-1-1   | False      |
      | group1-chd1-chd2 | f1-1-2 | s1-1-2   | False      |
      | group1-chd2      | f1-2   | s1-2     | True       |
      | group1-chd2-chd1 | f1-2-1 | s1-2-1   | False      |
      | group1-chd2-chd2 | f1-2-2 | s1-2-2   | False      |
      | group2           | f2     | s2       | True       |
      | group2-chd1      | f2-1   | s2-1     | True       |
      | group2-chd1-chd1 | f2-1-1 | s2-1-1   | False      |
      | group2-chd1-chd2 | f2-1-2 | s2-1-2   | False      |
      | group2-chd2      | f2-2   | s2-2     | True       |
      | group2-chd2-chd1 | f2-2-1 | s2-2-1   | False      |
      | group2-chd2-chd2 | f2-2-2 | s2-2-2   | False      |
    When Presenting "grouping column"
    Then The "GroupingColumn" column width should be 149 pixel
    When Click "expand" for row "group1"
    Then The "GroupingColumn" column width should be 159 pixel
    When Click "expand" for row "group1-chd1"
    Then The "GroupingColumn" column width should be 169 pixel
    When Click "expand" for row "group1-chd2"
    Then The "GroupingColumn" column width should be 169 pixel
    When Click "expand" for row "group2"
    Then The "GroupingColumn" column width should be 169 pixel
    When Click "collapse" for row "group1"
    Then The "GroupingColumn" column width should be 159 pixel
#    When Click "collapse" for row "group2"
#    Then The "GroupingColumn" column width should be 149 pixel
#    When Click "expand" for row "group1"
#    Then The "GroupingColumn" column width should be 169 pixel
#    When Click "collapse" for row "group1-chd1"
#    Then The "GroupingColumn" column width should be 159 pixel
#    When Click "expand" for row "group2"
#    Then The "GroupingColumn" column width should be 159 pixel
#    When Click "collapse" for row "group1-chd2"
#    Then The "GroupingColumn" column width should be 159 pixel
#    When Click "collapse" for row "group1"
#    Then The "GroupingColumn" column width should be 159 pixel
#    When Click "collapse" for row "group2"
#    Then The "GroupingColumn" column width should be 149 pixel

  @wip
  Scenario: Expand grouped row with partial loaded
    Given Given I have 200 grouped loans
    Then There should be 2 sections loaded
    When Customer drags scroll bar by offset 60 with 1 times
    Then There should be 3 sections loaded

  @wip
  Scenario: The default loading indicator should display when partial load grouped loans
    Given I have 200 grouped loans
    When Customer drags scroll bar by offset 60 with 1 times
    Then The default loading indicator should display

  @wip
  Scenario: The default loading indicator should display when partial load children loans
    Given I have the following grouped loans in MounteBank:
      | groupName | first | second |
      | group1    | f1    | s1     |
      | group2    | f2    | s2     |
      | group3    | f3    | s3     |
      | group4    | f4    | s4     |
      | group5    | f5    | s5     |
    When Presenting "grouping column present partial loaded children"
    And The row "group1" indicator should be "expand"
    When Customer drags scroll bar by offset 60 with 1 times
    Then The default loading indicator should display

  @wip
  Scenario: The custom loading indicator should display when partial load grouped loans
    Given I have 200 grouped loans
    When Customer drags scroll bar by offset 60 with 1 times
    Then The "custom" loading indicator should display

  @wip
  Scenario: The default loading indicator should display when partial load children loans
    Given I have the following grouped loans in MounteBank:
      | groupName | first | second |
      | group1    | f1    | s1     |
      | group2    | f2    | s2     |
      | group3    | f3    | s3     |
      | group4    | f4    | s4     |
      | group5    | f5    | s5     |
    When Presenting "grouping column present partial loaded children"
    And The row "group1" indicator should be "expand"
    When Customer drags scroll bar by offset 60 with 1 times
    Then The "custom" loading indicator should display

  @complete
  Scenario: The grouping column should not be resizable and draggable
    Given There are 5 grouped loans
    When Presenting "grouping column"
    Then The "GroupingColumn" column width should be 149 pixel
    Then The index 0 should be "GroupingColumn" column
    When The user drags the "GroupingColumn" on column to "right" with 100 pixel
    Then The "GroupingColumn" column width should be 149 pixel
    When Reorder an inner column "GroupingColumn" header to "right" with 300 pixel
    Then The index 0 should be "GroupingColumn" column


  @complete
  Scenario: The grouping column with two fixed column
    Given There are 5 grouped loans
    When Presenting "grouping column with fixed columns"
    And The user drags the "Activity" on column to "right" with 800 pixel
    And Drag horizontal scroll bar with 800 pixel
    Then The column header block should has "scroll left" and same as body scroll left
    And There are 3 grouping and fixed columns
    And The column "GroupingColumn" should be fixed
    And The column "Id" should be fixed
    And The column "Activity" should be fixed
    And The grouping and fixed columns should not be scrolled


  @wip
  Scenario: The children rows should be sorted by single column
    Given I have the following grouped loans in MounteBank:
      | groupName | first | second |
      | group1    | f1    | s1     |
      | group2    | f2    | s2     |
      | group3    | f3    | s3     |
      | group4    | f4    | s4     |
      | group5    | f5    | s5     |
    When Presenting "grouping column present grouped loans"
    Then I see grouped rows:
      | indicator | groupName | first | second |
      | +         | group1    | f1    | s1     |
      | +         | group2    | f2    | s2     |
      | +         | group3    | f3    | s3     |
      | +         | group4    | f4    | s4     |
      | +         | group5    | f5    | s5     |
    When Click "expand" for row "row_parent"
    Then I see grouped rows:
      | indicator | groupName   | first | second |
      | -         | group1      | f1    | s1     |
      | +         | group1-chd1 | f1-1  | s1-1   |
      | +         | group1-chd2 | f1-2  | s1-2   |
      | +         | group2      | f2    | s2     |
      | +         | group3      | f3    | s3     |
      | +         | group4      | f4    | s4     |
      | +         | group5      | f5    | s5     |
    When Click "expand" for row "group1-chd1"
    When Click "expand" for row "group1-chd2"
    Then I see grouped rows:
      | indicator | groupName        | first  | second |
      | -         | group1           | f1     | s1     |
      | -         | group1-chd1      | f1-1   | s1-1   |
      |           | group1-chd1-chd1 | f1-1-1 | s1-1-1 |
      |           | group1-chd1-chd2 | f1-1-2 | s1-1-2 |
      | -         | group1-chd2      | f1-2   | s1-2   |
      |           | group1-chd2-chd1 | f1-2-1 | s1-2-1 |
      |           | group1-chd2-chd2 | f1-2-2 | s1-2-2 |
      | +         | group2           | f2     | s2     |
      | +         | group3           | f3     | s3     |
      | +         | group4           | f4     | s4     |
      | +         | group5           | f5     | s5     |
    When Click to sort as "ASC" for column "first"
    Then I see grouped rows:
      | indicator | groupName        | first  | second |
      | -         | group1           | f1     | s1     |
      | -         | group1-chd1      | f1-1   | s1-1   |
      |           | group1-chd1-chd1 | f1-1-1 | s1-1-1 |
      |           | group1-chd1-chd2 | f1-1-2 | s1-1-2 |
      | -         | group1-chd2      | f1-2   | s1-2   |
      |           | group1-chd2-chd1 | f1-2-1 | s1-2-1 |
      |           | group1-chd2-chd2 | f1-2-2 | s1-2-2 |
      | +         | group2           | f2     | s2     |
      | +         | group3           | f3     | s3     |
      | +         | group4           | f4     | s4     |
      | +         | group5           | f5     | s5     |
    When Click to sort as "DESC" for column "first"
    Then I see grouped rows:
      | indicator | groupName        | first  | second |
      | -         | group1           | f1     | s1     |
      | -         | group1-chd1      | f1-1   | s1-1   |
      |           | group1-chd1-chd2 | f1-1-2 | s1-1-2 |
      |           | group1-chd1-chd1 | f1-1-1 | s1-1-1 |
      | -         | group1-chd2      | f1-2   | s1-2   |
      |           | group1-chd2-chd1 | f1-2-2 | s1-2-2 |
      |           | group1-chd2-chd2 | f1-2-1 | s1-2-1 |
      | +         | group2           | f2     | s2     |
      | +         | group3           | f3     | s3     |
      | +         | group4           | f4     | s4     |
      | +         | group5           | f5     | s5     |
