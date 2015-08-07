Feature: Multi-Column Sorting
  In order to perform complex sorts on multi-column datasets
  As a user presented with a grid
  I need an intuitive an set of controls to specify which columns to sort on

  @complete
  Scenario: Regular click when no existing sorting should sort ascending and then descending on column with no grouped row
    Given There are 200 loans in chunk size 50
    And Presenting "column sort"
    And Drag scroll bar to "bottom"
    And Drag scroll bar to "top"
    When Click to sort as "ASC" for column "Activity"
    Then I see rows:
      | Id  | Activity     | status    |
      | 0   | activity-0   | status0   |
      | 1   | activity-1   | status1   |
      | 10  | activity-10  | status10  |
      | 100 | activity-100 | status100 |
      | 101 | activity-101 | status101 |
      | 102 | activity-102 | status102 |
    And The "Activity" column sort indicator should be "asc"

    Given There are 200 loans in chunk size 50
    And Presenting "column sort"
    And Drag scroll bar to "bottom"
    And Drag scroll bar to "top"
    And Click to sort as "ASC" for column "Activity"
    When Click to sort as "DESC" for column "Activity"
    Then I see rows:
      | Id | Activity    | status   |
      | 99 | activity-99 | status99 |
      | 98 | activity-98 | status98 |
      | 97 | activity-97 | status97 |
      | 96 | activity-96 | status96 |
      | 95 | activity-95 | status95 |
      | 94 | activity-94 | status94 |
    And The "Activity" column sort indicator should be "desc"

    Given There are 200 loans in chunk size 50
    And Presenting "column sort"
    And Drag scroll bar to "bottom"
    And Drag scroll bar to "top"
    And Click to sort as "ASC" for column "Activity"
    And Click to sort as "DESC" for column "Activity"
    When Click to sort as "ASC" for column "Activity"
    Then I see rows:
      | Id  | Activity     | status    |
      | 0   | activity-0   | status0   |
      | 1   | activity-1   | status1   |
      | 10  | activity-10  | status10  |
      | 100 | activity-100 | status100 |
      | 101 | activity-101 | status101 |
      | 102 | activity-102 | status102 |
    And The "Activity" column sort indicator should be "asc"

    Given There are 200 loans in chunk size 50
    And Presenting "column sort"
    And Drag scroll bar to "bottom"
    And Drag scroll bar to "top"
    When "command" click to sort as "ASC" for column "Activity"
    Then I see rows:
      | Id  | Activity     | status    |
      | 0   | activity-0   | status0   |
      | 1   | activity-1   | status1   |
      | 10  | activity-10  | status10  |
      | 100 | activity-100 | status100 |
      | 101 | activity-101 | status101 |
      | 102 | activity-102 | status102 |
    And The "Activity" column sort indicator should be "asc"

  @complete
  Scenario: command click to remove a sort on column with grouped row fully load
    Given There are 200 loans in chunk size 50
    And Presenting "column sort"
    And Drag scroll bar to "bottom"
    And Drag scroll bar to "top"
    And Click to sort as "ASC" for column "Activity"
    And Click to sort as "DESC" for column "Activity"
    When "command" click to sort as "un-sort" for column "Activity"
    Then I see rows:
      | Id | Activity   | status  |
      | 0  | activity-0 | status0 |
      | 1  | activity-1 | status1 |
      | 2  | activity-2 | status2 |
      | 3  | activity-3 | status3 |
      | 4  | activity-4 | status4 |
      | 5  | activity-5 | status5 |
    And The "Activity" column sort indicator should be "none"

  @complete
  Scenario: Regular click when no existing sorting should sort ascending and then descending on column with grouped row fully load
    Given Prepare the grid with no existing sorting column for "fully load":
      | groupName        | id     | activity | isGroupRow |
      | group1           | f1     | s1       | True       |
      | group1-chd1      | f1-1   | s1-1     | True       |
      | group1-chd1-chd1 | f1-1-1 | s1-1-1   | False      |
      | group1-chd1-chd3 | f1-1-3 | s1-1-3   | False      |
      | group1-chd1-chd2 | f1-1-2 | s1-1-2   | False      |
      | group1-chd2      | f1-2   | s1-2     | True       |
      | group2           | f2     | s2       | True       |
      | group3           | f3     | s3       | True       |
      | group3-chd2      | f3-2   | s3-2     | False      |
      | group3-chd1      | f3-1   | s3-1     | False      |
    And Click "expand" for row "group1"
    And Click "expand" for row "group1-chd1"
    When Click to sort as "ASC" for column "Activity"
    Then I see grouped rows:
      | indicator | groupName        | Id     | Activity |
      | -         | group1           | f1     | s1       |
      | -         | group1-chd1      | f1-1   | s1-1     |
      |           | group1-chd1-chd1 | f1-1-1 | s1-1-1   |
      |           | group1-chd1-chd2 | f1-1-2 | s1-1-2   |
      |           | group1-chd1-chd3 | f1-1-3 | s1-1-3   |
      | +         | group1-chd2      | f1-2   | s1-2     |
      | +         | group2           | f2     | s2       |
    And The "Activity" column sort indicator should be "asc"

    Given Prepare the grid with no existing sorting column for "fully load":
      | groupName        | id     | activity | isGroupRow |
      | group1           | f1     | s1       | True       |
      | group1-chd1      | f1-1   | s1-1     | True       |
      | group1-chd1-chd1 | f1-1-1 | s1-1-1   | False      |
      | group1-chd1-chd3 | f1-1-3 | s1-1-3   | False      |
      | group1-chd1-chd2 | f1-1-2 | s1-1-2   | False      |
      | group1-chd2      | f1-2   | s1-2     | True       |
      | group2           | f2     | s2       | True       |
      | group3           | f3     | s3       | True       |
      | group3-chd2      | f3-2   | s3-2     | False      |
      | group3-chd1      | f3-1   | s3-1     | False      |
    And Click "expand" for row "group1"
    And Click "expand" for row "group1-chd1"
    And The grid sorted as "ASC" by "Activity" column:
      | indicator | groupName        | Id     | Activity |
      | -         | group1           | f1     | s1       |
      | -         | group1-chd1      | f1-1   | s1-1     |
      |           | group1-chd1-chd1 | f1-1-1 | s1-1-1   |
      |           | group1-chd1-chd2 | f1-1-2 | s1-1-2   |
      |           | group1-chd1-chd3 | f1-1-3 | s1-1-3   |
      | +         | group1-chd2      | f1-2   | s1-2     |
      | +         | group2           | f2     | s2       |
    When Click to sort as "DESC" for column "Activity"
    Then I see grouped rows:
      | indicator | groupName        | Id     | Activity |
      | -         | group1           | f1     | s1       |
      | -         | group1-chd1      | f1-1   | s1-1     |
      |           | group1-chd1-chd3 | f1-1-3 | s1-1-3   |
      |           | group1-chd1-chd2 | f1-1-2 | s1-1-2   |
      |           | group1-chd1-chd1 | f1-1-1 | s1-1-1   |
      | +         | group1-chd2      | f1-2   | s1-2     |
      | +         | group2           | f2     | s2       |
    And The "Activity" column sort indicator should be "desc"

    Given Prepare the grid with no existing sorting column for "fully load":
      | groupName        | id     | activity | isGroupRow |
      | group1           | f1     | s1       | True       |
      | group1-chd1      | f1-1   | s1-1     | True       |
      | group1-chd1-chd1 | f1-1-1 | s1-1-1   | False      |
      | group1-chd1-chd3 | f1-1-3 | s1-1-3   | False      |
      | group1-chd1-chd2 | f1-1-2 | s1-1-2   | False      |
      | group1-chd2      | f1-2   | s1-2     | True       |
      | group2           | f2     | s2       | True       |
      | group3           | f3     | s3       | True       |
      | group3-chd2      | f3-2   | s3-2     | False      |
      | group3-chd1      | f3-1   | s3-1     | False      |
    And Click "expand" for row "group1"
    And Click "expand" for row "group1-chd1"
    And The grid sorted as "DESC" by "Activity" column:
      | indicator | groupName        | Id     | Activity |
      | -         | group1           | f1     | s1       |
      | -         | group1-chd1      | f1-1   | s1-1     |
      |           | group1-chd1-chd3 | f1-1-3 | s1-1-3   |
      |           | group1-chd1-chd2 | f1-1-2 | s1-1-2   |
      |           | group1-chd1-chd1 | f1-1-1 | s1-1-1   |
      | +         | group1-chd2      | f1-2   | s1-2     |
      | +         | group2           | f2     | s2       |
    When Click to sort as "ASC" for column "Activity"
    Then I see grouped rows:
      | indicator | groupName        | Id     | Activity |
      | -         | group1           | f1     | s1       |
      | -         | group1-chd1      | f1-1   | s1-1     |
      |           | group1-chd1-chd1 | f1-1-1 | s1-1-1   |
      |           | group1-chd1-chd2 | f1-1-2 | s1-1-2   |
      |           | group1-chd1-chd3 | f1-1-3 | s1-1-3   |
      | +         | group1-chd2      | f1-2   | s1-2     |
      | +         | group2           | f2     | s2       |
    And The "Activity" column sort indicator should be "asc"

    Given Prepare the grid with no existing sorting column for "fully load":
      | groupName        | id     | activity | isGroupRow |
      | group1           | f1     | s1       | True       |
      | group1-chd1      | f1-1   | s1-1     | True       |
      | group1-chd1-chd1 | f1-1-1 | s1-1-1   | False      |
      | group1-chd1-chd3 | f1-1-3 | s1-1-3   | False      |
      | group1-chd1-chd2 | f1-1-2 | s1-1-2   | False      |
      | group1-chd2      | f1-2   | s1-2     | True       |
      | group2           | f2     | s2       | True       |
      | group3           | f3     | s3       | True       |
      | group3-chd2      | f3-2   | s3-2     | False      |
      | group3-chd1      | f3-1   | s3-1     | False      |
    And Click "expand" for row "group1"
    And Click "expand" for row "group1-chd1"
    When "command" click to sort as "ASC" for column "Activity"
    Then I see grouped rows:
      | indicator | groupName        | Id     | Activity |
      | -         | group1           | f1     | s1       |
      | -         | group1-chd1      | f1-1   | s1-1     |
      |           | group1-chd1-chd1 | f1-1-1 | s1-1-1   |
      |           | group1-chd1-chd2 | f1-1-2 | s1-1-2   |
      |           | group1-chd1-chd3 | f1-1-3 | s1-1-3   |
      | +         | group1-chd2      | f1-2   | s1-2     |
      | +         | group2           | f2     | s2       |
    And The "Activity" column sort indicator should be "asc"

  @complete
  Scenario: Check sort order
    Given Prepare the grid with no existing sorting column for "fully load":
      | groupName        | id     | activity | isGroupRow |
      | group1           | f1     | s1       | True       |
      | group1-chd1      | f1-1   | s1-1     | True       |
      | group1-chd1-chd1 | f1-1-1 | s1-1-1   | False      |
      | group1-chd1-chd3 | f1-1-3 | s1-1-3   | False      |
      | group1-chd1-chd2 | f1-1-2 | s1-1-2   | False      |
      | group1-chd2      | f1-2   | s1-2     | True       |
      | group2           | f2     | s2       | True       |
      | group3           | f3     | s3       | True       |
      | group3-chd2      | f3-2   | s3-2     | False      |
      | group3-chd1      | f3-1   | s3-1     | False      |
    And Click "expand" for row "group1"
    And Click "expand" for row "group1-chd1"
    And Click to sort as "ASC" for column "Activity"
    When Click to sort as "ASC" for column "Id"
    Then I see grouped rows:
      | indicator | groupName        | Id     | Activity |
      | -         | group1           | f1     | s1       |
      | -         | group1-chd1      | f1-1   | s1-1     |
      |           | group1-chd1-chd1 | f1-1-1 | s1-1-1   |
      |           | group1-chd1-chd2 | f1-1-2 | s1-1-2   |
      |           | group1-chd1-chd3 | f1-1-3 | s1-1-3   |
      | +         | group1-chd2      | f1-2   | s1-2     |
      | +         | group2           | f2     | s2       |
    And The "Activity" column sort indicator should be "none"
    And The "Id" column sort indicator should be "asc"

  @complete
  Scenario: command click to remove a sort on column with grouped row fully load
    Given Prepare the grid with no existing sorting column for "fully load":
      | groupName        | id     | activity | isGroupRow |
      | group1           | f1     | s1       | True       |
      | group1-chd1      | f1-1   | s1-1     | True       |
      | group1-chd1-chd1 | f1-1-1 | s1-1-1   | False      |
      | group1-chd1-chd3 | f1-1-3 | s1-1-3   | False      |
      | group1-chd1-chd2 | f1-1-2 | s1-1-2   | False      |
      | group1-chd2      | f1-2   | s1-2     | True       |
      | group2           | f2     | s2       | True       |
      | group3           | f3     | s3       | True       |
      | group3-chd2      | f3-2   | s3-2     | False      |
      | group3-chd1      | f3-1   | s3-1     | False      |
    And Click "expand" for row "group1"
    And Click "expand" for row "group1-chd1"
    And Click to sort as "ASC" for column "Id"
    When "command" click to sort as "un-sort" for column "Id"
    Then I see grouped rows:
      | indicator | groupName        | Id     | Activity |
      | -         | group1           | f1     | s1       |
      | -         | group1-chd1      | f1-1   | s1-1     |
      |           | group1-chd1-chd1 | f1-1-1 | s1-1-1   |
      |           | group1-chd1-chd3 | f1-1-3 | s1-1-3   |
      |           | group1-chd1-chd2 | f1-1-2 | s1-1-2   |
      | +         | group1-chd2      | f1-2   | s1-2     |
      | +         | group2           | f2     | s2       |
    And The "Id" column sort indicator should be "none"

  @complete
  Scenario: Regular click when no existing sorting should sort ascending and then descending on column with grouped row partial load
    Given Prepare the grid with no existing sorting column for "lazily load":
      | groupName                                        | id | Beginning DR (Base) |
      | accountSection[1]-accountType[1]-accountCode[11] |    | s                   |
    And Click "expand" for row "1"
    And Click "expand" for row "101"
    When Click to sort as "ASC" for column "Id"
    Then I see grouped rows:
      | indicator | groupName | Id    |
      | -         | 1         | 1     |
      | -         | 101       | 101   |
      |           | 10101     | 10101 |
      |           | 10102     | 10102 |
      |           | 10103     | 10103 |
      |           | 10104     | 10104 |
    And The "Id" column sort indicator should be "asc"

    Given Prepare the grid with no existing sorting column for "lazily load":
      | groupName                                        | id | Beginning DR (Base) |
      | accountSection[1]-accountType[1]-accountCode[11] |    | s                   |
    And Click "expand" for row "1"
    And Click "expand" for row "101"
    And The grid sorted as "ASC" by "Id" column:
      | indicator | groupName | Id    |
      | -         | 1         | 1     |
      | -         | 101       | 101   |
      |           | 10101     | 10101 |
      |           | 10102     | 10102 |
      |           | 10103     | 10103 |
      |           | 10104     | 10104 |
    When Click to sort as "DESC" for column "Id"
    Then I see grouped rows:
      | indicator | groupName | Id    |
      | -         | 1         | 1     |
      | -         | 101       | 101   |
      |           | 10111     | 10111 |
      |           | 10110     | 10110 |
      |           | 10109     | 10109 |
      |           | 10108     | 10108 |
    And The "Id" column sort indicator should be "desc"

    Given Prepare the grid with no existing sorting column for "lazily load":
      | groupName                                        | id | Beginning DR (Base) |
      | accountSection[1]-accountType[1]-accountCode[11] |    | s                   |
    And Click "expand" for row "1"
    And Click "expand" for row "101"
    And The grid sorted as "DESC" by "Id" column:
      | indicator | groupName | Id    |
      | -         | 1         | 1     |
      | -         | 101       | 101   |
      |           | 10111     | 10111 |
      |           | 10110     | 10110 |
      |           | 10109     | 10109 |
      |           | 10108     | 10108 |
    When Click to sort as "ASC" for column "Id"
    Then I see grouped rows:
      | indicator | groupName | Id    |
      | -         | 1         | 1     |
      | -         | 101       | 101   |
      |           | 10101     | 10101 |
      |           | 10102     | 10102 |
      |           | 10103     | 10103 |
      |           | 10104     | 10104 |

    Given Prepare the grid with no existing sorting column for "lazily load":
      | groupName                                        | id | Beginning DR (Base) |
      | accountSection[1]-accountType[1]-accountCode[11] |    | s                   |
    And Click "expand" for row "1"
    And Click "expand" for row "101"
    And The grid sorted as "DESC" by "Id" column:
      | indicator | groupName | Id    |
      | -         | 1         | 1     |
      | -         | 101       | 101   |
      |           | 10111     | 10111 |
      |           | 10110     | 10110 |
      |           | 10109     | 10109 |
      |           | 10108     | 10108 |
    When "command" click to sort as "un-sort" for column "Id"
    Then I see grouped rows:
      | indicator | groupName | Id    |
      | -         | 1         | 1     |
      | -         | 101       | 101   |
      |           | 10101     | 10101 |
      |           | 10102     | 10102 |
      |           | 10103     | 10103 |
      |           | 10104     | 10104 |
    And The "Id" column sort indicator should be "none"

  @complete
  Scenario: Control/Command click when no existing sorting should sort ascending and then descending on column with no grouped row
    Given There are 200 loans in chunk size 50
    And Presenting "column sort"
    And Drag scroll bar to "bottom"
    And Drag scroll bar to "top"
    When "command" click to sort as "ASC" for column "Activity"
    Then I see rows:
      | Id  | Activity     | status    |
      | 0   | activity-0   | status0   |
      | 1   | activity-1   | status1   |
      | 10  | activity-10  | status10  |
      | 100 | activity-100 | status100 |
      | 101 | activity-101 | status101 |
      | 102 | activity-102 | status102 |
    And The "Activity" column sort indicator should be "asc"

  @complete
  Scenario: Control/Command click when no existing sorting should sort ascending and then descending on column with grouped row fully load
    Given Prepare the grid with no existing sorting column for "fully load":
      | groupName        | id     | activity | isGroupRow |
      | group1           | f1     | s1       | True       |
      | group1-chd1      | f1-1   | s1-1     | True       |
      | group1-chd1-chd2 | f1-1-2 | f1-1-2   | False      |
      | group1-chd1-chd1 | f1-1-1 | f1-1-1   | False      |
      | group1-chd1-chd4 | f1-1-4 | f1-1-4   | False      |
      | group1-chd1-chd3 | f1-1-3 | f1-1-3   | False      |
      | group1-chd1-chd5 | f1-1-5 | f1-1-5   | False      |
      | group1-chd2      | f1-2   | s1-2     | True       |
      | group2           | f2     | s2       | True       |
    And Click "expand" for row "group1"
    And Click "expand" for row "group1-chd1"
    When "command" click to sort as "ASC" for column "Activity"
    Then I see grouped rows:
      | indicator | groupName        | Id     | Activity |
      | -         | group1           | f1     | s1       |
      | -         | group1-chd1      | f1-1   | s1-1     |
      |           | group1-chd1-chd1 | f1-1-1 | f1-1-1   |
      |           | group1-chd1-chd2 | f1-1-2 | f1-1-2   |
      |           | group1-chd1-chd3 | f1-1-3 | f1-1-3   |
      |           | group1-chd1-chd4 | f1-1-4 | f1-1-4   |
      |           | group1-chd1-chd5 | f1-1-5 | f1-1-5   |
      | +         | group1-chd2      | f1-2   | s1-2     |
      | +         | group2           | f2     | s2       |
    And The "Activity" column sort indicator should be "asc"

  @complete
  Scenario: Control/Command click when no existing sorting should sort ascending and then descending on column with grouped row partial load
    Given Prepare the grid with no existing sorting column for "lazily load":
      | groupName                                        | id | Beginning DR (Base) |
      | accountSection[1]-accountType[1]-accountCode[11] |    | s                   |
    And Click "expand" for row "1"
    And Click "expand" for row "101"
    When "command" click to sort as "ASC" for column "Id"
    Then I see grouped rows:
      | indicator | groupName | Id    |
      | -         | 1         | 1     |
      | -         | 101       | 101   |
      |           | 10101     | 10101 |
      |           | 10102     | 10102 |
      |           | 10103     | 10103 |
      |           | 10104     | 10104 |
    And The "Id" column sort indicator should be "asc"

    Given Prepare the grid with no existing sorting column for "lazily load":
      | groupName                                                             | id                        | beginningDr                |
      | accountSection[1]-accountType[1]-accountCode[2,1,4,3,5,6,7,8,9,10,11] | [2,1,4,3,5,6,7,8,9,10,11] | s[2,1,4,3,5,6,7,8,9,10,11] |
    And Click "expand" for row "1"
    And Click "expand" for row "101"
    And The grid sorted as "DESC" by "Beginning DR (Base)" column:
      | indicator | groupName | Id    | Beginning DR (Base) |
      | -         | 1         | 1     | s1                  |
      | -         | 101       | 101   | s1-1                |
      |           | 10109     | 10109 | s1-1-9              |
      |           | 10108     | 10108 | s1-1-8              |
      |           | 10107     | 10107 | s1-1-7              |
      |           | 10106     | 10106 | s1-1-6              |
      |           | 10105     | 10105 | s1-1-5              |
    When "command" click to sort as "no-sort" for column "Beginning DR (Base)"
    Then I see grouped rows:
      | indicator | groupName | Id    | Beginning DR (Base) |
      | -         | 1         | 1     | s1                  |
      | -         | 101       | 101   | s1-1                |
      |           | 10102     | 10102 | s1-1-2              |
      |           | 10101     | 10101 | s1-1-1              |
      |           | 10104     | 10104 | s1-1-4              |
      |           | 10103     | 10103 | s1-1-3              |
      |           | 10105     | 10105 | s1-1-5              |
    And The "Activity" column sort indicator should be "none"
    Then There should be 5 sections loaded

  @complete
  Scenario: Data sorted on a single column regular click on different column changes sort to that column with no grouped row
    Given There are 200 loans in chunk size 50
    And Presenting "column sort"
    And Drag scroll bar to "bottom"
    And Drag scroll bar to "top"
    And Click to sort as "ASC" for column "Activity"
    When Click to sort as "ASC" for column "status"
    Then I see rows:
      | Id  | Activity     | status    |
      | 0   | activity-0   | status0   |
      | 1   | activity-1   | status1   |
      | 10  | activity-10  | status10  |
      | 100 | activity-100 | status100 |
      | 101 | activity-101 | status101 |
      | 102 | activity-102 | status102 |
    And The "Activity" column sort indicator should be "none"
    And The "status" column sort indicator should be "asc"

  @complete
  Scenario: Data sorted on a single column regular click on different column changes sort to that column with grouped row fully load
    Given Prepare the grid with no existing sorting column for "fully load":
      | groupName        | id     | activity | status | isGroupRow |
      | group1           | f1     | s1       | t1     | True       |
      | group1-chd1      | f1-1   | s1-1     | t1-1   | True       |
      | group1-chd1-chd2 | f1-1-2 | s1-1-3   | t1-1-1 | False      |
      | group1-chd1-chd1 | f1-1-1 | s1-1-1   | t1-1-3 | False      |
      | group1-chd1-chd4 | f1-1-4 | s1-1-4   | t1-1-5 | False      |
      | group1-chd1-chd3 | f1-1-3 | s1-1-2   | t1-1-4 | False      |
      | group1-chd1-chd5 | f1-1-5 | s1-1-5   | t1-1-2 | False      |
      | group2           | f2     | s2       | t2     | True       |
    And Click "expand" for row "group1"
    And Click "expand" for row "group1-chd1"
    And The grid sorted as "ASC" by "Activity" column:
      | indicator | groupName        | Id     | Activity | status |
      | -         | group1           | f1     | s1       | t1     |
      | -         | group1-chd1      | f1-1   | s1-1     | t1-1   |
      |           | group1-chd1-chd1 | f1-1-1 | s1-1-1   | t1-1-3 |
      |           | group1-chd1-chd3 | f1-1-3 | s1-1-2   | t1-1-4 |
      |           | group1-chd1-chd2 | f1-1-2 | s1-1-3   | t1-1-1 |
      |           | group1-chd1-chd4 | f1-1-4 | s1-1-4   | t1-1-5 |
      |           | group1-chd1-chd5 | f1-1-5 | s1-1-5   | t1-1-2 |
      | +         | group2           | f2     | s2       | t2     |
    When Click to sort as "ASC" for column "status"
    Then I see grouped rows:
      | indicator | groupName        | Id     | Activity | status |
      | -         | group1           | f1     | s1       | t1     |
      | -         | group1-chd1      | f1-1   | s1-1     | t1-1   |
      |           | group1-chd1-chd2 | f1-1-2 | s1-1-3   | t1-1-1 |
      |           | group1-chd1-chd5 | f1-1-5 | s1-1-5   | t1-1-2 |
      |           | group1-chd1-chd1 | f1-1-1 | s1-1-1   | t1-1-3 |
      |           | group1-chd1-chd3 | f1-1-3 | s1-1-2   | t1-1-4 |
      |           | group1-chd1-chd4 | f1-1-4 | s1-1-4   | t1-1-5 |
      | +         | group2           | f2     | s2       | t2     |
    And The "Activity" column sort indicator should be "none"
    And The "status" column sort indicator should be "asc"

  @complete
  Scenario: Data sorted on a single column regular click on different column changes sort to that column with grouped row partial load
    Given Prepare the grid with no existing sorting column for "lazily load":
      | groupName                                                             | id                        | beginningDr                | beginningCr                |
      | accountSection[1]-accountType[1]-accountCode[1,3,2,4,5,6,7,8,9,10,11] | [1,3,2,4,5,6,7,8,9,10,11] | s[1,2,3,4,5,6,7,8,9,10,11] | t[3,4,1,5,2,6,7,8,9,10,11] |
    And Click "expand" for row "1"
    And Click "expand" for row "101"
    And The grid sorted as "ASC" by "Beginning DR (Base)" column:
      | indicator | groupName | Id    | Beginning DR (Base) | Beginning CR (Base) |
      | -         | 1         | 1     | s1                  | t1                  |
      | -         | 101       | 101   | s1-1                | t1-1                |
      |           | 10101     | 10101 | s1-1-1              | t1-1-3              |
      |           | 10110     | 10110 | s1-1-10             | t1-1-10             |
      |           | 10111     | 10111 | s1-1-11             | t1-1-11             |
      |           | 10103     | 10103 | s1-1-2              | t1-1-4              |
      |           | 10102     | 10102 | s1-1-3              | t1-1-1              |
    When Click to sort as "ASC" for column "Beginning CR (Base)"
    Then I see grouped rows:
      | indicator | groupName | Id    | Beginning DR (Base) | Beginning CR (Base) |
      | -         | 1         | 1     | s1                  | t1                  |
      | -         | 101       | 101   | s1-1                | t1-1                |
      |           | 10102     | 10102 | s1-1-3              | t1-1-1              |
      |           | 10110     | 10110 | s1-1-10             | t1-1-10             |
      |           | 10111     | 10111 | s1-1-11             | t1-1-11             |
      |           | 10105     | 10105 | s1-1-5              | t1-1-2              |
      |           | 10101     | 10101 | s1-1-1              | t1-1-3              |
    And The "Beginning DR (Base)" column sort indicator should be "none"
    And The "Beginning CR (Base)" column sort indicator should be "asc"
    And There should be 5 sections loaded

  @complete
  Scenario: Data sorted on a single column regular click on different column more than twice time with no grouped row
    Given There are 200 loans in chunk size 50
    And Presenting "column sort"
    And Drag scroll bar to "bottom"
    And Drag scroll bar to "top"
    And Click to sort as "ASC" for column "Id"
    And Click to sort as "ASC" for column "Activity"
    When Click to sort as "ASC" for column "Id"
    Then I see rows:
      | Id | Activity   | status  |
      | 0  | activity-0 | status0 |
      | 1  | activity-1 | status1 |
      | 2  | activity-2 | status2 |
      | 3  | activity-3 | status3 |
      | 4  | activity-4 | status4 |
      | 5  | activity-5 | status5 |
    And The "Id" column sort indicator should be "asc"

  @complete
  Scenario: Data sorted on a single column regular click on different column more than twice time with grouped row fully loaded
    Given Prepare the grid with no existing sorting column for "fully load":
      | groupName        | id     | activity | status | isGroupRow |
      | group1           | f1     | s1       | t1     | True       |
      | group1-chd1      | f1-1   | s1-1     | t1-1   | True       |
      | group1-chd1-chd2 | f1-1-2 | s1-1-3   | t1-1-1 | False      |
      | group1-chd1-chd1 | f1-1-1 | s1-1-1   | t1-1-3 | False      |
      | group1-chd1-chd4 | f1-1-4 | s1-1-4   | t1-1-5 | False      |
      | group1-chd1-chd3 | f1-1-3 | s1-1-2   | t1-1-4 | False      |
      | group1-chd1-chd5 | f1-1-5 | s1-1-5   | t1-1-2 | False      |
      | group2           | f2     | s2       | t2     | True       |
    And Click "expand" for row "group1"
    And Click "expand" for row "group1-chd1"
    And Click to sort as "ASC" for column "Activity"
    And Click to sort as "ASC" for column "Id"
    When Click to sort as "ASC" for column "Activity"
    Then Then I see grouped rows:
      | indicator | groupName        | Id     | Activity | status |
      | -         | group1           | f1     | s1       | t1     |
      | -         | group1-chd1      | f1-1   | s1-1     | t1-1   |
      |           | group1-chd1-chd1 | f1-1-1 | s1-1-1   | t1-1-3 |
      |           | group1-chd1-chd3 | f1-1-3 | s1-1-2   | t1-1-4 |
      |           | group1-chd1-chd2 | f1-1-2 | s1-1-3   | t1-1-1 |
      |           | group1-chd1-chd4 | f1-1-4 | s1-1-4   | t1-1-5 |
      |           | group1-chd1-chd5 | f1-1-5 | s1-1-5   | t1-1-2 |
      | +         | group2           | f2     | s2       | t2     |
    And The "Activity" column sort indicator should be "asc"

  @complete
  Scenario: Data sorted on a single column regular click on different column more than twice time with grouped row lazily loaded
    Given Prepare the grid with no existing sorting column for "lazily load":
      | groupName                                        | id | beginningDr |
      | accountSection[1]-accountType[1]-accountCode[11] |    | s           |
    And Click "expand" for row "1"
    And Click "expand" for row "101"
    And Click to sort as "ASC" for column "Id"
    And Click to sort as "ASC" for column "Beginning DR (Base)"
    When Click to sort as "ASC" for column "Id"
    Then I see grouped rows:
      | indicator | groupName | Id    |
      | -         | 1         | 1     |
      | -         | 101       | 101   |
      |           | 10101     | 10101 |
      |           | 10102     | 10102 |
      |           | 10103     | 10103 |
      |           | 10104     | 10104 |
    And The "Id" column sort indicator should be "asc"

  @complete
  Scenario: Sort column twice time and collapse root row
    Given Prepare the grid with no existing sorting column for "lazily load":
      | groupName                                        | id   |
      | accountSection[1]-accountType[1]-accountCode[11] | [11] |
    And Click "expand" for row "1"
    And Click "expand" for row "101"
    And Click to sort as "ASC" for column "Id"
    And Click to sort as "DESC" for column "Id"
    When Click "collapse" for row "1"
    And Click "expand" for row "1"
    Then I see grouped rows:
      | indicator | groupName | Id    |
      | -         | 1         | 1     |
      | -         | 101       | 101   |
      |           | 10111     | 10111 |
      |           | 10110     | 10110 |
      |           | 10109     | 10109 |
      |           | 10108     | 10108 |

  @complete
  Scenario: Data sorted on a single column control/command click on different column adds the column to the sort then regular click different column with no grouped row
    Given There are 200 loans in chunk size 50
    And Presenting "column sort"
    And Drag scroll bar to "bottom"
    And Drag scroll bar to "top"
    And Click to sort as "ASC" for column "Activity"
    When "command" click to sort as "ASC" for column "status"
    Then I see rows:
      | Id  | Activity     | status    | Use    | Sector    |
      | 0   | activity-0   | status0   | use0   | sector0   |
      | 1   | activity-1   | status1   | use1   | sector0   |
      | 10  | activity-10  | status10  | use10  | sector9   |
      | 100 | activity-100 | status100 | use100 | sector99  |
      | 101 | activity-101 | status101 | use101 | sector99  |
      | 102 | activity-102 | status102 | use102 | sector102 |
    And The "Activity" column sort indicator should be "asc"
    And The "status" column sort indicator should be "asc"
    And The "Activity" column sort order is "1"
    And The "status" column sort order is "2"

    Given There are 200 loans in chunk size 50
    And Presenting "column sort"
    And Drag scroll bar to "bottom"
    And Drag scroll bar to "top"
    And The grid sorted as "ASC" by "Activity, status" columns
    When "command" click to sort as "ASC" for column "Use"
    Then I see rows:
      | Id  | Activity     | status    | Use    | Sector    |
      | 0   | activity-0   | status0   | use0   | sector0   |
      | 1   | activity-1   | status1   | use1   | sector0   |
      | 10  | activity-10  | status10  | use10  | sector9   |
      | 100 | activity-100 | status100 | use100 | sector99  |
      | 101 | activity-101 | status101 | use101 | sector99  |
      | 102 | activity-102 | status102 | use102 | sector102 |
    And The "Activity" column sort indicator should be "asc"
    And The "status" column sort indicator should be "asc"
    And The "Use" column sort indicator should be "asc"
    And The "Activity" column sort order is "1"
    And The "status" column sort order is "2"
    And The "Use" column sort order is "3"

    Given There are 200 loans in chunk size 50
    And Presenting "column sort"
    And Drag scroll bar to "bottom"
    And Drag scroll bar to "top"
    And The grid sorted as "ASC" by "Activity, status, Use" columns
    When Click to sort as "ASC" for column "Sector"
    Then I see rows:
      | Id  | Activity     | status    | Use    | Sector    |
      | 0   | activity-0   | status0   | use0   | sector0   |
      | 1   | activity-1   | status1   | use1   | sector0   |
      | 2   | activity-2   | status2   | use2   | sector0   |
      | 104 | activity-104 | status104 | use104 | sector102 |
      | 103 | activity-103 | status103 | use103 | sector102 |
      | 102 | activity-102 | status102 | use102 | sector102 |
    And The "Activity" column sort indicator should be "none"
    And The "status" column sort indicator should be "none"
    And The "Use" column sort indicator should be "none"
    And The "Sector" column sort indicator should be "asc"

  @complete
  Scenario: Data sorted on a single column control/command click on different column adds the column to the sort then regular click different column with grouped row fully load
    Given Prepare the grid with no existing sorting column for "fully load":
      | groupName        | id     | activity | status | use     | sector  | isGroupRow |
      | group1           | f1     | s1       | t1     | fo1     | fi1     | True       |
      | group1-chd1      | f1-1   | s1-1     | t1-1   | fo1-1   | fi1-1   | True       |
      | group1-chd1-chd1 | f1-1-1 | s1-1-2   | t1-1-1 | fo1-1-4 | fi1-1-5 | False      |
      | group1-chd1-chd2 | f1-1-2 | s1-1-1   | t1-1-3 | fo1-1-1 | fi1-1-2 | False      |
      | group1-chd1-chd3 | f1-1-3 | s1-1-2   | t1-1-5 | fo1-1-3 | fi1-1-1 | False      |
      | group1-chd1-chd4 | f1-1-4 | s1-1-2   | t1-1-1 | fo1-1-2 | fi1-1-3 | False      |
      | group1-chd1-chd5 | f1-1-5 | s1-1-3   | t1-1-2 | fo1-1-5 | fi1-1-4 | False      |
    And Click "expand" for row "group1"
    And Click "expand" for row "group1-chd1"
    And The grid sorted as "ASC" by "Activity" column:
      | indicator | groupName        | Id     | Activity | status | Use     | Sector  |
      | -         | group1           | f1     | s1       | t1     | fo1     | fi1     |
      | -         | group1-chd1      | f1-1   | s1-1     | t1-1   | fo1-1   | fi1-1   |
      |           | group1-chd1-chd2 | f1-1-2 | s1-1-1   | t1-1-3 | fo1-1-1 | fi1-1-2 |
      |           | group1-chd1-chd1 | f1-1-1 | s1-1-2   | t1-1-1 | fo1-1-4 | fi1-1-5 |
      |           | group1-chd1-chd3 | f1-1-3 | s1-1-2   | t1-1-5 | fo1-1-3 | fi1-1-1 |
      |           | group1-chd1-chd4 | f1-1-4 | s1-1-2   | t1-1-1 | fo1-1-2 | fi1-1-3 |
      |           | group1-chd1-chd5 | f1-1-5 | s1-1-3   | t1-1-2 | fo1-1-5 | fi1-1-4 |
    When "command" click to sort as "ASC" for column "status"
    Then I see grouped rows:
      | indicator | groupName        | Id     | Activity | status | Use     | Sector  |
      | -         | group1           | f1     | s1       | t1     | fo1     | fi1     |
      | -         | group1-chd1      | f1-1   | s1-1     | t1-1   | fo1-1   | fi1-1   |
      |           | group1-chd1-chd2 | f1-1-2 | s1-1-1   | t1-1-3 | fo1-1-1 | fi1-1-2 |
      |           | group1-chd1-chd1 | f1-1-1 | s1-1-2   | t1-1-1 | fo1-1-4 | fi1-1-5 |
      |           | group1-chd1-chd4 | f1-1-4 | s1-1-2   | t1-1-1 | fo1-1-2 | fi1-1-3 |
      |           | group1-chd1-chd3 | f1-1-3 | s1-1-2   | t1-1-5 | fo1-1-3 | fi1-1-1 |
      |           | group1-chd1-chd5 | f1-1-5 | s1-1-3   | t1-1-2 | fo1-1-5 | fi1-1-4 |
    And The "Activity" column sort indicator should be "asc"
    And The "status" column sort indicator should be "asc"
    And The "Activity" column sort order is "1"
    And The "status" column sort order is "2"

    Given Prepare the grid with no existing sorting column for "fully load":
      | groupName        | id     | activity | status | use     | sector  | isGroupRow |
      | group1           | f1     | s1       | t1     | fo1     | fi1     | True       |
      | group1-chd1      | f1-1   | s1-1     | t1-1   | fo1-1   | fi1-1   | True       |
      | group1-chd1-chd1 | f1-1-1 | s1-1-2   | t1-1-1 | fo1-1-4 | fi1-1-5 | False      |
      | group1-chd1-chd2 | f1-1-2 | s1-1-1   | t1-1-3 | fo1-1-1 | fi1-1-2 | False      |
      | group1-chd1-chd3 | f1-1-3 | s1-1-2   | t1-1-5 | fo1-1-3 | fi1-1-1 | False      |
      | group1-chd1-chd4 | f1-1-4 | s1-1-2   | t1-1-1 | fo1-1-2 | fi1-1-3 | False      |
      | group1-chd1-chd5 | f1-1-5 | s1-1-3   | t1-1-2 | fo1-1-5 | fi1-1-4 | False      |
    And Click "expand" for row "group1"
    And Click "expand" for row "group1-chd1"
    And The grid sorted as "ASC" by "Activity, status" columns
    And I see grouped rows:
      | indicator | groupName        | Id     | Activity | status | Use     | Sector  |
      | -         | group1           | f1     | s1       | t1     | fo1     | fi1     |
      | -         | group1-chd1      | f1-1   | s1-1     | t1-1   | fo1-1   | fi1-1   |
      |           | group1-chd1-chd2 | f1-1-2 | s1-1-1   | t1-1-3 | fo1-1-1 | fi1-1-2 |
      |           | group1-chd1-chd1 | f1-1-1 | s1-1-2   | t1-1-1 | fo1-1-4 | fi1-1-5 |
      |           | group1-chd1-chd4 | f1-1-4 | s1-1-2   | t1-1-1 | fo1-1-2 | fi1-1-3 |
      |           | group1-chd1-chd3 | f1-1-3 | s1-1-2   | t1-1-5 | fo1-1-3 | fi1-1-1 |
      |           | group1-chd1-chd5 | f1-1-5 | s1-1-3   | t1-1-2 | fo1-1-5 | fi1-1-4 |
    When "command" click to sort as "ASC" for column "Use"
    Then I see grouped rows:
      | indicator | groupName        | Id     | Activity | status | Use     | Sector  |
      | -         | group1           | f1     | s1       | t1     | fo1     | fi1     |
      | -         | group1-chd1      | f1-1   | s1-1     | t1-1   | fo1-1   | fi1-1   |
      |           | group1-chd1-chd2 | f1-1-2 | s1-1-1   | t1-1-3 | fo1-1-1 | fi1-1-2 |
      |           | group1-chd1-chd4 | f1-1-4 | s1-1-2   | t1-1-1 | fo1-1-2 | fi1-1-3 |
      |           | group1-chd1-chd1 | f1-1-1 | s1-1-2   | t1-1-1 | fo1-1-4 | fi1-1-5 |
      |           | group1-chd1-chd3 | f1-1-3 | s1-1-2   | t1-1-5 | fo1-1-3 | fi1-1-1 |
      |           | group1-chd1-chd5 | f1-1-5 | s1-1-3   | t1-1-2 | fo1-1-5 | fi1-1-4 |
    And The "Activity" column sort indicator should be "asc"
    And The "status" column sort indicator should be "asc"
    And The "Use" column sort indicator should be "asc"
    And The "Activity" column sort order is "1"
    And The "status" column sort order is "2"
    And The "Use" column sort order is "3"

    Given Prepare the grid with no existing sorting column for "fully load":
      | groupName        | id     | activity | status | use     | sector  | isGroupRow |
      | group1           | f1     | s1       | t1     | fo1     | fi1     | True       |
      | group1-chd1      | f1-1   | s1-1     | t1-1   | fo1-1   | fi1-1   | True       |
      | group1-chd1-chd1 | f1-1-1 | s1-1-2   | t1-1-1 | fo1-1-4 | fi1-1-5 | False      |
      | group1-chd1-chd2 | f1-1-2 | s1-1-1   | t1-1-3 | fo1-1-1 | fi1-1-2 | False      |
      | group1-chd1-chd3 | f1-1-3 | s1-1-2   | t1-1-5 | fo1-1-3 | fi1-1-1 | False      |
      | group1-chd1-chd4 | f1-1-4 | s1-1-2   | t1-1-1 | fo1-1-2 | fi1-1-3 | False      |
      | group1-chd1-chd5 | f1-1-5 | s1-1-3   | t1-1-2 | fo1-1-5 | fi1-1-4 | False      |
    And Click "expand" for row "group1"
    And Click "expand" for row "group1-chd1"
    And The grid sorted as "ASC" by "Activity, status, Use" columns
    And I see grouped rows:
      | indicator | groupName        | Id     | Activity | status | Use     | Sector  |
      | -         | group1           | f1     | s1       | t1     | fo1     | fi1     |
      | -         | group1-chd1      | f1-1   | s1-1     | t1-1   | fo1-1   | fi1-1   |
      |           | group1-chd1-chd2 | f1-1-2 | s1-1-1   | t1-1-3 | fo1-1-1 | fi1-1-2 |
      |           | group1-chd1-chd4 | f1-1-4 | s1-1-2   | t1-1-1 | fo1-1-2 | fi1-1-3 |
      |           | group1-chd1-chd1 | f1-1-1 | s1-1-2   | t1-1-1 | fo1-1-4 | fi1-1-5 |
      |           | group1-chd1-chd3 | f1-1-3 | s1-1-2   | t1-1-5 | fo1-1-3 | fi1-1-1 |
      |           | group1-chd1-chd5 | f1-1-5 | s1-1-3   | t1-1-2 | fo1-1-5 | fi1-1-4 |
    When Click to sort as "ASC" for column "Sector"
    Then I see grouped rows:
      | indicator | groupName        | Id     | Activity | status | Use     | Sector  |
      | -         | group1           | f1     | s1       | t1     | fo1     | fi1     |
      | -         | group1-chd1      | f1-1   | s1-1     | t1-1   | fo1-1   | fi1-1   |
      |           | group1-chd1-chd3 | f1-1-3 | s1-1-2   | t1-1-5 | fo1-1-3 | fi1-1-1 |
      |           | group1-chd1-chd2 | f1-1-2 | s1-1-1   | t1-1-3 | fo1-1-1 | fi1-1-2 |
      |           | group1-chd1-chd4 | f1-1-4 | s1-1-2   | t1-1-1 | fo1-1-2 | fi1-1-3 |
      |           | group1-chd1-chd5 | f1-1-5 | s1-1-3   | t1-1-2 | fo1-1-5 | fi1-1-4 |
      |           | group1-chd1-chd1 | f1-1-1 | s1-1-2   | t1-1-1 | fo1-1-4 | fi1-1-5 |
    And The "Activity" column sort indicator should be "none"
    And The "status" column sort indicator should be "none"
    And The "status" column sort indicator should be "none"
    And The "Use" column sort indicator should be "none"
    And The "Sector" column sort indicator should be "asc"

  @complete
  Scenario: Data sorted on a single column control/command click on different column adds the column to the sort then regular click different column with grouped row partial load
    Given Prepare the grid with no existing sorting column for "lazily load":
      | groupName                                                             | id                        | beginningDr                | beginningCr                | netBeginning                |
      | accountSection[1]-accountType[1]-accountCode[1,2,3,4,5,6,7,8,9,10,11] | [1,2,3,4,5,6,7,8,9,10,11] | s[2,1,2,2,3,6,7,8,9,10,11] | t[1,3,5,1,2,6,7,8,9,10,11] | fo[4,1,3,2,5,6,7,8,9,10,11] |
    And Click "expand" for row "1"
    And Click "expand" for row "101"
    And The grid sorted as "ASC" by "Beginning DR (Base)" column:
      | indicator | groupName | Id    | Beginning DR (Base) | Beginning CR (Base) | Net Beginning (Base) |
      | -         | 1         | 1     | s1                  | t1                  | fo1                  |
      | -         | 101       | 101   | s1-1                | t1-1                | fo1-1                |
      |           | 10102     | 10102 | s1-1-1              | t1-1-3              | fo1-1-1              |
      |           | 10110     | 10110 | s1-1-10             | t1-1-10             | fo1-1-10             |
      |           | 10111     | 10111 | s1-1-11             | t1-1-11             | fo1-1-11             |
      |           | 10101     | 10101 | s1-1-2              | t1-1-1              | fo1-1-4              |
      |           | 10103     | 10103 | s1-1-2              | t1-1-5              | fo1-1-3              |
    When "command" click to sort as "ASC" for column "Beginning CR (Base)"
    Then I see grouped rows:
      | indicator | groupName | Id    | Beginning DR (Base) | Beginning CR (Base) | Net Beginning (Base) |
      | -         | 1         | 1     | s1                  | t1                  | fo1                  |
      | -         | 101       | 101   | s1-1                | t1-1                | fo1-1                |
      |           | 10102     | 10102 | s1-1-1              | t1-1-3              | fo1-1-1              |
      |           | 10110     | 10110 | s1-1-10             | t1-1-10             | fo1-1-10             |
      |           | 10111     | 10111 | s1-1-11             | t1-1-11             | fo1-1-11             |
      |           | 10101     | 10101 | s1-1-2              | t1-1-1              | fo1-1-4              |
      |           | 10104     | 10104 | s1-1-2              | t1-1-1              | fo1-1-2              |
    And The "Beginning DR (Base)" column sort indicator should be "asc"
    And The "Beginning CR (Base)" column sort indicator should be "asc"

    Given Prepare the grid with no existing sorting column for "lazily load":
      | groupName                                                             | id                        | beginningDr                | beginningCr                | netBeginning                |
      | accountSection[1]-accountType[1]-accountCode[1,2,3,4,5,6,7,8,9,10,11] | [1,2,3,4,5,6,7,8,9,10,11] | s[2,1,2,2,3,6,7,8,9,10,11] | t[1,3,5,1,2,6,7,8,9,10,11] | fo[4,1,3,2,5,6,7,8,9,10,11] |
    And Click "expand" for row "1"
    And Click "expand" for row "101"
    And The grid sorted as "ASC" by "Beginning DR (Base), Beginning CR (Base)" columns
    And I see grouped rows:
      | indicator | groupName | Id    | Beginning DR (Base) | Beginning CR (Base) | Net Beginning (Base) |
      | -         | 1         | 1     | s1                  | t1                  | fo1                  |
      | -         | 101       | 101   | s1-1                | t1-1                | fo1-1                |
      |           | 10102     | 10102 | s1-1-1              | t1-1-3              | fo1-1-1              |
      |           | 10110     | 10110 | s1-1-10             | t1-1-10             | fo1-1-10             |
      |           | 10111     | 10111 | s1-1-11             | t1-1-11             | fo1-1-11             |
      |           | 10101     | 10101 | s1-1-2              | t1-1-1              | fo1-1-4              |
      |           | 10104     | 10104 | s1-1-2              | t1-1-1              | fo1-1-2              |
    When "command" click to sort as "ASC" for column "Net Beginning (Base)"
    Then I see grouped rows:
      | indicator | groupName | Id    | Beginning DR (Base) | Beginning CR (Base) | Net Beginning (Base) |
      | -         | 1         | 1     | s1                  | t1                  | fo1                  |
      | -         | 101       | 101   | s1-1                | t1-1                | fo1-1                |
      |           | 10102     | 10102 | s1-1-1              | t1-1-3              | fo1-1-1              |
      |           | 10110     | 10110 | s1-1-10             | t1-1-10             | fo1-1-10             |
      |           | 10111     | 10111 | s1-1-11             | t1-1-11             | fo1-1-11             |
      |           | 10104     | 10104 | s1-1-2              | t1-1-1              | fo1-1-2              |
      |           | 10101     | 10101 | s1-1-2              | t1-1-1              | fo1-1-4              |
    And The "Beginning DR (Base)" column sort indicator should be "asc"
    And The "Beginning CR (Base)" column sort indicator should be "asc"
    And The "Net Beginning (Base)" column sort indicator should be "asc"
    And There should be 6 sections loaded
    And The "Beginning DR (Base)" column sort order is "1"
    And The "Beginning CR (Base)" column sort order is "2"
    And The "Net Beginning (Base)" column sort order is "3"

  @complete
  Scenario: Data sorted on a multiple columns regular click on existing column toggles direction for that column then remove column from sort with no grouped row
    Given There are 200 loans in chunk size 50
    And Presenting "column sort"
    And Drag scroll bar to "bottom"
    And Drag scroll bar to "top"
    And The grid sorted as "ASC" by "Activity, status" columns
    When Click to sort as "DESC" for column "Activity"
    Then I see rows:
      | Id | Activity    | status   | Use   | Sector   |
      | 99 | activity-99 | status99 | use99 | sector99 |
      | 98 | activity-98 | status98 | use98 | sector96 |
      | 97 | activity-97 | status97 | use97 | sector96 |
      | 96 | activity-96 | status96 | use96 | sector96 |
      | 95 | activity-95 | status95 | use95 | sector93 |
      | 94 | activity-94 | status94 | use94 | sector93 |
    And The "Activity" column sort indicator should be "desc"
    And The "status" column sort indicator should be "asc"
    And The "Activity" column sort order is "1"
    And The "status" column sort order is "2"

    Given There are 200 loans in chunk size 50
    And Presenting "column sort"
    And Drag scroll bar to "bottom"
    And Drag scroll bar to "top"
    And The grid sorted as "ASC" by "Activity, status, Use" columns
    When "command" click to sort as "remove" for column "Activity"
    Then I see rows:
      | Id  | Activity     | status    | Use    | Sector    |
      | 0   | activity-0   | status0   | use0   | sector0   |
      | 1   | activity-1   | status1   | use1   | sector0   |
      | 10  | activity-10  | status10  | use10  | sector9   |
      | 100 | activity-100 | status100 | use100 | sector99  |
      | 101 | activity-101 | status101 | use101 | sector99  |
      | 102 | activity-102 | status102 | use102 | sector102 |
    And The "Activity" column sort indicator should be "none"
    And The "status" column sort indicator should be "asc"
    And The "Use" column sort indicator should be "asc"
    And The "status" column sort order is "1"
    And The "Use" column sort order is "2"

  @complete1
  Scenario: Data sorted on a multiple columns regular click on existing column toggles direction for that column then remove column from sort with grouped row fully load
    Given Prepare the grid with no existing sorting column for "fully load":
      | groupName        | id     | activity | status | use     | sector  | isGroupRow |
      | group1           | f1     | s1       | t1     | fo1     | fi1     | True       |
      | group1-chd1      | f1-1   | s1-1     | t1-1   | fo1-1   | fi1-1   | True       |
      | group1-chd1-chd1 | f1-1-1 | s1-1-2   | t1-1-1 | fo1-1-4 | fi1-1-5 | False      |
      | group1-chd1-chd2 | f1-1-2 | s1-1-1   | t1-1-3 | fo1-1-1 | fi1-1-2 | False      |
      | group1-chd1-chd3 | f1-1-3 | s1-1-2   | t1-1-5 | fo1-1-3 | fi1-1-1 | False      |
      | group1-chd1-chd4 | f1-1-4 | s1-1-2   | t1-1-1 | fo1-1-2 | fi1-1-3 | False      |
      | group1-chd1-chd5 | f1-1-5 | s1-1-3   | t1-1-2 | fo1-1-5 | fi1-1-4 | False      |
    And Click "expand" for row "group1"
    And Click "expand" for row "group1-chd1"
    And The grid sorted as "ASC" by "Activity, status" columns
    And I see grouped rows:
      | indicator | groupName        | Id     | Activity | status | Use     | Sector  |
      | -         | group1           | f1     | s1       | t1     | fo1     | fi1     |
      | -         | group1-chd1      | f1-1   | s1-1     | t1-1   | fo1-1   | fi1-1   |
      |           | group1-chd1-chd2 | f1-1-2 | s1-1-1   | t1-1-3 | fo1-1-1 | fi1-1-2 |
      |           | group1-chd1-chd1 | f1-1-1 | s1-1-2   | t1-1-1 | fo1-1-4 | fi1-1-5 |
      |           | group1-chd1-chd4 | f1-1-4 | s1-1-2   | t1-1-1 | fo1-1-2 | fi1-1-3 |
      |           | group1-chd1-chd3 | f1-1-3 | s1-1-2   | t1-1-5 | fo1-1-3 | fi1-1-1 |
      |           | group1-chd1-chd5 | f1-1-5 | s1-1-3   | t1-1-2 | fo1-1-5 | fi1-1-4 |
    When Click to sort as "DESC" for column "Activity"
    Then I see grouped rows:
      | indicator | groupName        | Id     | Activity | status | Use     | Sector  |
      | -         | group1           | f1     | s1       | t1     | fo1     | fi1     |
      | -         | group1-chd1      | f1-1   | s1-1     | t1-1   | fo1-1   | fi1-1   |
      |           | group1-chd1-chd5 | f1-1-5 | s1-1-3   | t1-1-2 | fo1-1-5 | fi1-1-4 |
      |           | group1-chd1-chd1 | f1-1-1 | s1-1-2   | t1-1-1 | fo1-1-4 | fi1-1-5 |
      |           | group1-chd1-chd4 | f1-1-4 | s1-1-2   | t1-1-1 | fo1-1-2 | fi1-1-3 |
      |           | group1-chd1-chd3 | f1-1-3 | s1-1-2   | t1-1-5 | fo1-1-3 | fi1-1-1 |
      |           | group1-chd1-chd2 | f1-1-2 | s1-1-1   | t1-1-3 | fo1-1-1 | fi1-1-2 |
    And The "Activity" column sort indicator should be "desc"
    And The "status" column sort indicator should be "asc"
    And The "Activity" column sort order is "1"
    And The "status" column sort order is "2"

    Given Prepare the grid with no existing sorting column for "fully load":
      | groupName        | id     | activity | status | use     | sector  | isGroupRow |
      | group1           | f1     | s1       | t1     | fo1     | fi1     | True       |
      | group1-chd1      | f1-1   | s1-1     | t1-1   | fo1-1   | fi1-1   | True       |
      | group1-chd1-chd1 | f1-1-1 | s1-1-2   | t1-1-1 | fo1-1-4 | fi1-1-5 | False      |
      | group1-chd1-chd2 | f1-1-2 | s1-1-1   | t1-1-3 | fo1-1-1 | fi1-1-2 | False      |
      | group1-chd1-chd3 | f1-1-3 | s1-1-2   | t1-1-5 | fo1-1-3 | fi1-1-1 | False      |
      | group1-chd1-chd4 | f1-1-4 | s1-1-2   | t1-1-1 | fo1-1-2 | fi1-1-3 | False      |
      | group1-chd1-chd5 | f1-1-5 | s1-1-3   | t1-1-2 | fo1-1-5 | fi1-1-4 | False      |
    And Click "expand" for row "group1"
    And Click "expand" for row "group1-chd1"
    And The grid sorted as "ASC" by "Activity, status" columns
    And I see grouped rows:
      | indicator | groupName        | Id     | Activity | status | Use     | Sector  |
      | -         | group1           | f1     | s1       | t1     | fo1     | fi1     |
      | -         | group1-chd1      | f1-1   | s1-1     | t1-1   | fo1-1   | fi1-1   |
      |           | group1-chd1-chd2 | f1-1-2 | s1-1-1   | t1-1-3 | fo1-1-1 | fi1-1-2 |
      |           | group1-chd1-chd1 | f1-1-1 | s1-1-2   | t1-1-1 | fo1-1-4 | fi1-1-5 |
      |           | group1-chd1-chd4 | f1-1-4 | s1-1-2   | t1-1-1 | fo1-1-2 | fi1-1-3 |
      |           | group1-chd1-chd3 | f1-1-3 | s1-1-2   | t1-1-5 | fo1-1-3 | fi1-1-1 |
      |           | group1-chd1-chd5 | f1-1-5 | s1-1-3   | t1-1-2 | fo1-1-5 | fi1-1-4 |
    When "command" click to sort as "remove" for column "Activity"
    Then I see grouped rows:
      | indicator | groupName        | Id     | Activity | status | Use     | Sector  |
      | -         | group1           | f1     | s1       | t1     | fo1     | fi1     |
      | -         | group1-chd1      | f1-1   | s1-1     | t1-1   | fo1-1   | fi1-1   |
      |           | group1-chd1-chd1 | f1-1-1 | s1-1-2   | t1-1-1 | fo1-1-4 | fi1-1-5 |
      |           | group1-chd1-chd4 | f1-1-4 | s1-1-2   | t1-1-1 | fo1-1-2 | fi1-1-3 |
      |           | group1-chd1-chd5 | f1-1-5 | s1-1-3   | t1-1-2 | fo1-1-5 | fi1-1-4 |
      |           | group1-chd1-chd2 | f1-1-2 | s1-1-1   | t1-1-3 | fo1-1-1 | fi1-1-2 |
      |           | group1-chd1-chd3 | f1-1-3 | s1-1-2   | t1-1-5 | fo1-1-3 | fi1-1-1 |
    And The "Activity" column sort indicator should be "none"
    And The "status" column sort indicator should be "asc"
    And The "status" column sort order is "blank"

  @complete
  Scenario: Data sorted on a single column control/command click on different column adds the column to the sort then regular click different column with grouped row partial load
    Given Prepare the grid with no existing sorting column for "lazily load":
      | groupName                                                             | id                        | beginningDr                | beginningCr                | netBeginning                |
      | accountSection[1]-accountType[1]-accountCode[1,2,3,4,5,6,7,8,9,10,11] | [1,2,3,4,5,6,7,8,9,10,11] | s[2,1,2,2,3,6,7,8,9,10,11] | t[1,3,5,1,2,6,7,8,9,10,11] | fo[4,1,3,2,5,6,7,8,9,10,11] |
    And Click "expand" for row "1"
    And Click "expand" for row "101"
    And The grid sorted as "ASC" by "Beginning DR (Base), Beginning CR (Base)" columns
    And I see grouped rows:
      | indicator | groupName | Id    | Beginning DR (Base) | Beginning CR (Base) | Net Beginning (Base) |
      | -         | 1         | 1     | s1                  | t1                  | fo1                  |
      | -         | 101       | 101   | s1-1                | t1-1                | fo1-1                |
      |           | 10102     | 10102 | s1-1-1              | t1-1-3              | fo1-1-1              |
      |           | 10110     | 10110 | s1-1-10             | t1-1-10             | fo1-1-10             |
      |           | 10111     | 10111 | s1-1-11             | t1-1-11             | fo1-1-11             |
      |           | 10101     | 10101 | s1-1-2              | t1-1-1              | fo1-1-4              |
      |           | 10104     | 10104 | s1-1-2              | t1-1-1              | fo1-1-2              |
    When Click to sort as "DESC" for column "Beginning DR (Base)"
    Then I see grouped rows:
      | indicator | groupName | Id    | Beginning DR (Base) | Beginning CR (Base) | Net Beginning (Base) |
      | -         | 1         | 1     | s1                  | t1                  | fo1                  |
      | -         | 101       | 101   | s1-1                | t1-1                | fo1-1                |
      |           | 10109     | 10109 | s1-1-9              | t1-1-9              | fo1-1-9              |
      |           | 10108     | 10108 | s1-1-8              | t1-1-8              | fo1-1-8              |
      |           | 10107     | 10107 | s1-1-7              | t1-1-7              | fo1-1-7              |
      |           | 10106     | 10106 | s1-1-6              | t1-1-6              | fo1-1-6              |
      |           | 10105     | 10105 | s1-1-3              | t1-1-2              | fo1-1-5              |
    And The "Beginning DR (Base)" column sort indicator should be "desc"
    And The "Beginning CR (Base)" column sort indicator should be "asc"
    And There should be 6 sections loaded

    Given Prepare the grid with no existing sorting column for "lazily load":
      | groupName                                                             | id                        | beginningDr                | beginningCr                | netBeginning                |
      | accountSection[1]-accountType[1]-accountCode[1,2,3,4,5,6,7,8,9,10,11] | [1,2,3,4,5,6,7,8,9,10,11] | s[2,1,2,2,3,6,7,8,9,10,11] | t[1,3,5,1,2,6,7,8,9,10,11] | fo[4,1,3,2,5,6,7,8,9,10,11] |
    And Click "expand" for row "1"
    And Click "expand" for row "101"
    And The grid sorted as "ASC" by "Beginning DR (Base), Beginning CR (Base), Net Beginning (Base)" columns:
      | indicator | groupName | Id    | Beginning DR (Base) | Beginning CR (Base) | Net Beginning (Base) |
      | -         | 1         | 1     | s1                  | t1                  | fo1                  |
      | -         | 101       | 101   | s1-1                | t1-1                | fo1-1                |
      |           | 10102     | 10102 | s1-1-1              | t1-1-3              | fo1-1-1              |
      |           | 10110     | 10110 | s1-1-10             | t1-1-10             | fo1-1-10             |
      |           | 10111     | 10111 | s1-1-11             | t1-1-11             | fo1-1-11             |
      |           | 10104     | 10104 | s1-1-2              | t1-1-1              | fo1-1-2              |
      |           | 10101     | 10101 | s1-1-2              | t1-1-1              | fo1-1-4              |
      |           | 10103     | 10103 | s1-1-2              | t1-1-5              | fo1-1-3              |
      |           | 10105     | 10105 | s1-1-3              | t1-1-2              | fo1-1-5              |
    When "command" click to sort as "remove" for column "Beginning DR (Base)"
    Then I see grouped rows:
      | indicator | groupName | Id    | Beginning DR (Base) | Beginning CR (Base) | Net Beginning (Base) |
      | -         | 1         | 1     | s1                  | t1                  | fo1                  |
      | -         | 101       | 101   | s1-1                | t1-1                | fo1-1                |
      |           | 10104     | 10104 | s1-1-2              | t1-1-1              | fo1-1-2              |
      |           | 10101     | 10101 | s1-1-2              | t1-1-1              | fo1-1-4              |
      |           | 10110     | 10110 | s1-1-10             | t1-1-10             | fo1-1-10             |
      |           | 10111     | 10111 | s1-1-11             | t1-1-11             | fo1-1-11             |
      |           | 10105     | 10105 | s1-1-3              | t1-1-2              | fo1-1-5              |
    And The "Beginning DR (Base)" column sort indicator should be "none"
    And The "Beginning CR (Base)" column sort indicator should be "asc"
    And There should be 7 sections loaded
