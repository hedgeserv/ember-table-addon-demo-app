Feature: Multi-Column Sorting
  In order to perform complex sorts on multi-column datasets
  As a user presented with a grid
  I need an intuitive an set of controls to specify which columns to sort on

  @wip
  Scenario: Regular click when no existing sorting should sort ascending and then descending on column with no grouped row
    Given Prepare the grid with no existing sorting column for "fully load":
      | groupName | id | activity | isGroupRow |
      | group2    | f2 | s2       | False      |
      | group1    | f1 | s1       | False      |
      | group4    | f4 | s4       | False      |
      | group3    | f3 | s3       | False      |
      | group5    | f5 | s5       | False      |
    When Click to sort as "ASC" for column "Activity"
    Then I see grouped rows:
      | indicator | groupName | Id | Activity |
      | +         | group1    | f1 | s1       |
      | +         | group2    | f2 | s2       |
      | +         | group3    | f3 | s3       |
      | +         | group4    | f4 | s4       |
      | +         | group5    | f5 | s5       |
    And The "Activity" column sort indicator should be "asc"

    Given Prepare the grid with no existing sorting column for "fully load":
      | groupName | id | activity | isGroupRow |
      | group2    | f2 | s2       | False      |
      | group1    | f1 | s1       | False      |
      | group4    | f4 | s4       | False      |
      | group3    | f3 | s3       | False      |
      | group5    | f5 | s5       | False      |
    And The grid sorted as "ASC" by "Activity" column:
      | indicator | groupName | Id | Activity |
      | +         | group1    | f1 | s1       |
      | +         | group2    | f2 | s2       |
      | +         | group3    | f3 | s3       |
      | +         | group4    | f4 | s4       |
      | +         | group5    | f5 | s5       |
    When Click to sort as "DESC" for column "Activity"
    Then I see grouped rows:
      | indicator | groupName | Id | Activity |
      | +         | group5    | f5 | s5       |
      | +         | group4    | f4 | s4       |
      | +         | group3    | f3 | s3       |
      | +         | group2    | f2 | s2       |
      | +         | group1    | f1 | s1       |
    And The "Activity" column sort indicator should be "desc"

    Given Prepare the grid with no existing sorting column for "fully load":
      | groupName | id | activity | isGroupRow |
      | group2    | f2 | s2       | False      |
      | group1    | f1 | s1       | False      |
      | group4    | f4 | s4       | False      |
      | group3    | f3 | s3       | False      |
      | group5    | f5 | s5       | False      |
    And The grid sorted as "DESC" by "Activity" column:
      | indicator | groupName | Id | Activity |
      | +         | group5    | f5 | s5       |
      | +         | group4    | f4 | s4       |
      | +         | group3    | f3 | s3       |
      | +         | group2    | f2 | s2       |
      | +         | group1    | f1 | s1       |
    When Click to sort as "ASC" for column "Activity"
    Then I see grouped rows:
      | indicator | groupName | Id | Activity |
      | +         | group1    | f1 | s1       |
      | +         | group2    | f2 | s2       |
      | +         | group3    | f3 | s3       |
      | +         | group4    | f4 | s4       |
      | +         | group5    | f5 | s5       |

  @wip
  Scenario: Regular click when no existing sorting should sort ascending and then descending on column with grouped row fully load
    Given Prepare the grid with no existing sorting column for "fully load":
      | groupName   | id   | activity | isGroupRow |
      | group1      | f1   | s1       | True       |
      | group1-chd2 | f1-2 | s1-2     | False      |
      | group1-chd1 | f1-1 | s1-1     | False      |
      | group2      | f2   | s2       | True       |
      | group3      | f3   | s3       | True       |
      | group3-chd2 | f3-2 | s3-2     | False      |
      | group3-chd2 | f3-1 | s3-1     | False      |
      | group4      | f4   | s4       | True       |
      | group5      | f5   | s5       | True       |
    When Click to sort as "ASC" for column "Activity"
    Then I see grouped rows:
      | groupName   | id   | activity | isGroupRow |
      | group1      | f1   | s1       | True       |
      | group1-chd1 | f1-1 | s1-1     | False      |
      | group1-chd2 | f1-2 | s1-2     | False      |
      | group2      | f2   | s2       | True       |
      | group3      | f3   | s3       | True       |
      | group3-chd2 | f3-1 | s3-1     | False      |
      | group3-chd2 | f3-2 | s3-2     | False      |
      | group4      | f4   | s4       | True       |
      | group5      | f5   | s5       | True       |
    And The "Activity" column sort indicator should be "asc"

    Given Prepare the grid with no existing sorting column for "fully load":
      | groupName   | id   | activity | isGroupRow |
      | group1      | f1   | s1       | True       |
      | group1-chd2 | f1-2 | s1-2     | False      |
      | group1-chd3 | f1-3 | s1-3     | False      |
      | group1-chd1 | f1-1 | s1-1     | False      |
      | group2      | f2   | s2       | True       |
      | group3      | f3   | s3       | True       |
      | group3-chd3 | f3-3 | s3-3     | False      |
      | group3-chd1 | f3-1 | s3-1     | False      |
      | group3-chd2 | f3-2 | s3-2     | False      |
    And The grid sorted as "ASC" by "Activity" column:
      | groupName   | id   | activity | isGroupRow |
      | group1      | f1   | s1       | True       |
      | group1-chd1 | f1-1 | s1-1     | False      |
      | group1-chd2 | f1-2 | s1-2     | False      |
      | group1-chd3 | f1-3 | s1-3     | False      |
      | group2      | f2   | s2       | True       |
      | group3      | f3   | s3       | True       |
      | group3-chd1 | f3-1 | s3-1     | False      |
      | group3-chd2 | f3-2 | s3-2     | False      |
      | group3-chd3 | f3-3 | s3-3     | False      |
    When Click to sort as "DESC" for column "Activity"
    Then I see grouped rows:
      | groupName   | id   | activity | isGroupRow |
      | group1      | f1   | s1       | True       |
      | group1-chd3 | f1-3 | s1-3     | False      |
      | group1-chd2 | f1-2 | s1-2     | False      |
      | group1-chd1 | f1-1 | s1-1     | False      |
      | group2      | f2   | s2       | True       |
      | group3      | f3   | s3       | True       |
      | group3-chd3 | f3-3 | s3-3     | False      |
      | group3-chd2 | f3-2 | s3-2     | False      |
      | group3-chd1 | f3-1 | s3-1     | False      |
    And The "Activity" column sort indicator should be "desc"

    Given Prepare the grid with no existing sorting column for "fully load":
      | groupName   | id   | activity | isGroupRow |
      | group1      | f1   | s1       | True       |
      | group1-chd2 | f1-2 | s1-2     | False      |
      | group1-chd3 | f1-3 | s1-3     | False      |
      | group1-chd1 | f1-1 | s1-1     | False      |
      | group2      | f2   | s2       | True       |
      | group3      | f3   | s3       | True       |
      | group3-chd3 | f3-3 | s3-3     | False      |
      | group3-chd1 | f3-1 | s3-1     | False      |
      | group3-chd2 | f3-2 | s3-2     | False      |
    And The grid sorted as "DESC" by "Activity" column:
      | groupName   | id   | activity | isGroupRow |
      | group1      | f1   | s1       | True       |
      | group1-chd3 | f1-3 | s1-3     | False      |
      | group1-chd2 | f1-2 | s1-2     | False      |
      | group1-chd1 | f1-1 | s1-1     | False      |
      | group2      | f2   | s2       | True       |
      | group3      | f3   | s3       | True       |
      | group3-chd3 | f3-3 | s3-3     | False      |
      | group3-chd2 | f3-2 | s3-2     | False      |
      | group3-chd1 | f3-1 | s3-1     | False      |
    When Click to sort as "ASC" for column "Activity"
    Then I see grouped rows:
      | groupName   | id   | activity | isGroupRow |
      | group1      | f1   | s1       | True       |
      | group1-chd1 | f1-1 | s1-1     | False      |
      | group1-chd2 | f1-2 | s1-2     | False      |
      | group1-chd3 | f1-3 | s1-3     | False      |
      | group2      | f2   | s2       | True       |
      | group3      | f3   | s3       | True       |
      | group3-chd1 | f3-1 | s3-1     | False      |
      | group3-chd2 | f3-2 | s3-2     | False      |
      | group3-chd3 | f3-3 | s3-3     | False      |

  @wip
  Scenario: Regular click when no existing sorting should sort ascending and then descending on column with grouped row partial load
    Given Prepare the grid with no existing sorting column for "lazily load":
      | groupName                                        | id | Beginning DR (Base) |
      | accountSection[1]-accountType[1]-accountCode[11] | f  | s                   |
    And Click "expand" for row "f1"
    And Click "expand" for row "f1-1"
    When Click to sort as "ASC" for column "Id"
    Then I see grouped rows:
      | indicator | groupName | Id      |
      | -         | f1        | f1      |
      | -         | f1-1      | f1-1    |
      |           | f1-1-1    | f1-1-1  |
      |           | f1-1-10   | f1-1-10 |
      |           | f1-1-11   | f1-1-11 |
      |           | f1-1-2    | f1-1-2  |
    And The "Id" column sort indicator should be "asc"

    Given Prepare the grid with no existing sorting column for "lazily load":
      | groupName                                        | id | Beginning DR (Base) |
      | accountSection[1]-accountType[1]-accountCode[11] | f  | s                   |
    And Click "expand" for row "f1"
    And Click "expand" for row "f1-1"
    And The grid sorted as "ASC" by "Id" column:
      | indicator | groupName | Id      |
      | -         | f1        | f1      |
      | -         | f1-1      | f1-1    |
      |           | f1-1-1    | f1-1-1  |
      |           | f1-1-10   | f1-1-10 |
      |           | f1-1-11   | f1-1-11 |
      |           | f1-1-2    | f1-1-2  |
    When Click to sort as "DESC" for column "Id"
    Then I see grouped rows:
      | indicator | groupName | Id     |
      | -         | f1        | f1     |
      | -         | f1-1      | f1-1   |
      |           | f1-1-9    | f1-1-9 |
      |           | f1-1-8    | f1-1-8 |
      |           | f1-1-7    | f1-1-7 |
      |           | f1-1-6    | f1-1-6 |
    And The "Id" column sort indicator should be "desc"

    Given Prepare the grid with no existing sorting column for "lazily load":
      | groupName                                        | id | Beginning DR (Base) |
      | accountSection[1]-accountType[1]-accountCode[11] | f  | s                   |
    And Click "expand" for row "f1"
    And Click "expand" for row "f1-1"
    And The grid sorted as "DESC" by "Id" column:
      | indicator | groupName | Id     |
      | -         | f1        | f1     |
      | -         | f1-1      | f1-1   |
      |           | f1-1-9    | f1-1-9 |
      |           | f1-1-8    | f1-1-8 |
      |           | f1-1-7    | f1-1-7 |
      |           | f1-1-6    | f1-1-6 |
    When Click to sort as "ASC" for column "Id"
    Then I see grouped rows:
      | indicator | groupName | Id      |
      | -         | f1        | f1      |
      | -         | f1-1      | f1-1    |
      |           | f1-1-1    | f1-1-1  |
      |           | f1-1-10   | f1-1-10 |
      |           | f1-1-11   | f1-1-11 |
      |           | f1-1-2    | f1-1-2  |

  @wip
  Scenario: Control/Command click when no existing sorting should sort ascending and then descending on column with no grouped row
    Given Prepare the grid with no existing sorting column for "fully load":
      | groupName | id | activity | isGroupRow |
      | group2    | f2 | s2       | False      |
      | group1    | f1 | s1       | False      |
      | group4    | f4 | s4       | False      |
      | group3    | f3 | s3       | False      |
      | group5    | f5 | s5       | False      |
    When "command" click to sort as "ASC" for column "Activity"
    Then I see grouped rows:
      | indicator | groupName | Id | Activity |
      | +         | group1    | f1 | s1       |
      | +         | group2    | f2 | s2       |
      | +         | group3    | f3 | s3       |
      | +         | group4    | f4 | s4       |
      | +         | group5    | f5 | s5       |
    And The "Activity" column sort indicator should be "asc"

    Given Prepare the grid with no existing sorting column for "fully load":
      | groupName | id | activity | isGroupRow |
      | group2    | f2 | s2       | False      |
      | group1    | f1 | s1       | False      |
      | group4    | f4 | s4       | False      |
      | group3    | f3 | s3       | False      |
      | group5    | f5 | s5       | False      |
    And The grid sorted as "ASC" by "Activity" column:
      | indicator | groupName | Id | Activity |
      | +         | group1    | f1 | s1       |
      | +         | group2    | f2 | s2       |
      | +         | group3    | f3 | s3       |
      | +         | group4    | f4 | s4       |
      | +         | group5    | f5 | s5       |
    When Click to sort as "DESC" for column "Activity"
    Then I see grouped rows:
      | indicator | groupName | Id | Activity |
      | +         | group5    | f5 | s5       |
      | +         | group4    | f4 | s4       |
      | +         | group3    | f3 | s3       |
      | +         | group2    | f2 | s2       |
      | +         | group1    | f1 | s1       |
    And The "Activity" column sort indicator should be "desc"

    Given Prepare the grid with no existing sorting column for "fully load":
      | groupName | id | activity | isGroupRow |
      | group2    | f2 | s2       | False      |
      | group1    | f1 | s1       | False      |
      | group4    | f4 | s4       | False      |
      | group3    | f3 | s3       | False      |
      | group5    | f5 | s5       | False      |
    And The grid sorted as "DESC" by "Activity" column:
      | indicator | groupName | Id | Activity |
      | +         | group5    | f5 | s5       |
      | +         | group4    | f4 | s4       |
      | +         | group3    | f3 | s3       |
      | +         | group2    | f2 | s2       |
      | +         | group1    | f1 | s1       |
    When "command" click to sort as "no-sort" for column "Activity"
    Then I see grouped rows:
      | indicator | groupName | Id | Activity |
      | +         | group2    | f2 | s2       |
      | +         | group1    | f1 | s1       |
      | +         | group4    | f4 | s4       |
      | +         | group3    | f3 | s3       |
      | +         | group5    | f5 | s5       |
    And The "Activity" column sort indicator should be "none"

  @wip
  Scenario: Control/Command click when no existing sorting should sort ascending and then descending on column with grouped row fully load
    Given Prepare the grid with no existing sorting column for "fully load":
      | groupName   | id   | activity | isGroupRow |
      | group1      | f1   | s1       | True       |
      | group1-chd2 | f1-2 | f1-2     | False      |
      | group1-chd1 | f1-1 | f1-1     | False      |
      | group1-chd4 | f1-4 | f1-4     | False      |
      | group1-chd3 | f1-3 | f1-3     | False      |
      | group1-chd5 | f1-5 | f1-5     | False      |
      | group2      | f2   | s2       | True       |
    And Click "expand" for row "group1"
    When "command" click to sort as "ASC" for column "Activity"
    Then I see grouped rows:
      | indicator | groupName   | Id          | Activity    |
      | -         | group1      | group1      | group1      |
      |           | group1-chd1 | group1-chd1 | group1-chd1 |
      |           | group1-chd2 | group1-chd2 | group1-chd2 |
      |           | group1-chd3 | group1-chd3 | group1-chd3 |
      |           | group1-chd4 | group1-chd4 | group1-chd4 |
      |           | group1-chd5 | group1-chd5 | group1-chd5 |
      | +         | group2      | group2      | group2      |
    And The "Activity" column sort indicator should be "asc"

    Given Prepare the grid with no existing sorting column for "fully load":
      | groupName   | id   | activity | isGroupRow |
      | group1      | f1   | s1       | True       |
      | group1-chd2 | f1-2 | f1-2     | False      |
      | group1-chd1 | f1-1 | f1-1     | False      |
      | group1-chd4 | f1-4 | f1-4     | False      |
      | group1-chd3 | f1-3 | f1-3     | False      |
      | group1-chd5 | f1-5 | f1-5     | False      |
      | group2      | f2   | s2       | True       |
    And Click "expand" for row "group1"
    And The grid sorted as "ASC" by "Activity" column:
      | indicator | groupName   | Id          | Activity    |
      | -         | group1      | group1      | group1      |
      |           | group1-chd1 | group1-chd1 | group1-chd1 |
      |           | group1-chd2 | group1-chd2 | group1-chd2 |
      |           | group1-chd3 | group1-chd3 | group1-chd3 |
      |           | group1-chd4 | group1-chd4 | group1-chd4 |
      |           | group1-chd5 | group1-chd5 | group1-chd5 |
      | +         | group2      | group2      | group2      |
    When Click to sort as "DESC" for column "Activity"
    Then I see grouped rows:
      | indicator | groupName   | Id          | Activity    |
      | -         | group1      | group1      | group1      |
      |           | group1-chd5 | group1-chd5 | group1-chd5 |
      |           | group1-chd4 | group1-chd4 | group1-chd4 |
      |           | group1-chd3 | group1-chd3 | group1-chd3 |
      |           | group1-chd2 | group1-chd2 | group1-chd2 |
      |           | group1-chd1 | group1-chd1 | group1-chd1 |
      | +         | group2      | group2      | group2      |
    And The "Activity" column sort indicator should be "desc"

    Given Prepare the grid with no existing sorting column for "fully load":
      | groupName   | id   | activity | isGroupRow |
      | group1      | f1   | s1       | True       |
      | group1-chd2 | f1-2 | f1-2     | False      |
      | group1-chd1 | f1-1 | f1-1     | False      |
      | group1-chd4 | f1-4 | f1-4     | False      |
      | group1-chd3 | f1-3 | f1-3     | False      |
      | group1-chd5 | f1-5 | f1-5     | False      |
      | group2      | f2   | s2       | True       |
    And Click "expand" for row "group1"
    And The grid sorted as "DESC" by "Activity" column:
      | indicator | groupName   | Id          | Activity    |
      | -         | group1      | group1      | group1      |
      |           | group1-chd5 | group1-chd5 | group1-chd5 |
      |           | group1-chd4 | group1-chd4 | group1-chd4 |
      |           | group1-chd3 | group1-chd3 | group1-chd3 |
      |           | group1-chd2 | group1-chd2 | group1-chd2 |
      |           | group1-chd1 | group1-chd1 | group1-chd1 |
      | +         | group2      | group2      | group2      |
    When "command" click to sort as "no-sort" for column "Activity"
    Then I see grouped rows:
      | indicator | groupName   | Id          | Activity    |
      | -         | group1      | group1      | group1      |
      |           | group1-chd2 | group1-chd2 | group1-chd2 |
      |           | group1-chd1 | group1-chd1 | group1-chd1 |
      |           | group1-chd4 | group1-chd4 | group1-chd4 |
      |           | group1-chd3 | group1-chd3 | group1-chd3 |
      |           | group1-chd5 | group1-chd5 | group1-chd5 |
      | +         | group2      | group2      | group2      |
    And The "Activity" column sort indicator should be "none"

  @wip
  Scenario: Control/Command click when no existing sorting should sort ascending and then descending on column with grouped row partial load
    Given Prepare the grid with no existing sorting column for "lazily load":
      | groupName                                        | id | Beginning DR (Base) |
      | accountSection[1]-accountType[1]-accountCode[11] | f  | s                   |
    And Click "expand" for row "f1"
    And Click "expand" for row "f1-1"
    When "command" click to sort as "ASC" for column "Activity"
    Then I see grouped rows:
      | indicator | groupName | Id      | Activity |
      | -         | f1        | f1      | s1       |
      | -         | f1-1      | f1-1    | s1-1     |
      |           | f1-1-1    | f1-1-1  | s1-1-1   |
      |           | f1-1-10   | f1-1-10 | s1-1-10  |
      |           | f1-1-11   | f1-1-11 | s1-1-11  |
      |           | f1-1-2    | f1-1-2  | s1-1-2   |
    And The "Activity" column sort indicator should be "asc"

    Given Prepare the grid with no existing sorting column for "lazily load":
      | groupName                                        | id | Beginning DR (Base) |
      | accountSection[1]-accountType[1]-accountCode[11] | f  | s                   |
    And Click "expand" for row "f1"
    And Click "expand" for row "f1-1"
    And The grid sorted as "ASC" by "Activity" column:
      | indicator | groupName | Id      | Activity |
      | -         | f1        | f1      | s1       |
      | -         | f1-1      | f1-1    | s1-1     |
      |           | f1-1-1    | f1-1-1  | s1-1-1   |
      |           | f1-1-10   | f1-1-10 | s1-1-10  |
      |           | f1-1-11   | f1-1-11 | s1-1-11  |
      |           | f1-1-2    | f1-1-2  | s1-1-2   |
    When Click to sort as "DESC" for column "Activity"
    Then I see grouped rows:
      | indicator | groupName | Id     | Activity |
      | -         | f1        | f1     | s1       |
      | -         | f1-1      | f1-1   | s1-1     |
      |           | f1-1-9    | f1-1-9 | s1-1-9   |
      |           | f1-1-8    | f1-1-8 | s1-1-8   |
      |           | f1-1-7    | f1-1-7 | s1-1-7   |
      |           | f1-1-6    | f1-1-6 | s1-1-6   |
    And The "Activity" column sort indicator should be "desc"

    Given Prepare the grid with no existing sorting column for "lazily load":
      | groupName                                               | id           | Beginning DR (Base) |
      | accountSection[1]-accountType[1]-accountCode[2,1,4,3,5] | f[2,1,4,3,5] | s[2,1,4,3,5]        |
    And Click "expand" for row "f1"
    And Click "expand" for row "f1-1"
    And The grid sorted as "DESC" by "Activity" column:
      | indicator | groupName | Id     | Activity |
      | -         | f1        | f1     | s1       |
      | -         | f1-1      | f1-1   | s1-1     |
      |           | f1-1-5    | f1-1-5 | s1-1-5   |
      |           | f1-1-4    | f1-1-4 | s1-1-4   |
      |           | f1-1-3    | f1-1-3 | s1-1-3   |
      |           | f1-1-2    | f1-1-2 | s1-1-2   |
      |           | f1-1-1    | f1-1-1 | s1-1-1   |
    When "command" click to sort as "no-sort" for column "Activity"
    Then I see grouped rows:
      | indicator | groupName | Id   | Activity |
      | -         | f1        | f1   | s1       |
      |           | f1-2      | f1-2 | s1-2     |
      |           | f1-1      | f1-1 | s1-1     |
      |           | f1-4      | f1-4 | s1-4     |
      |           | f1-3      | f1-3 | s1-3     |
      |           | f1-5      | f1-5 | s1-5     |
    And The "Activity" column sort indicator should be "none"

  @wip
  Scenario: Data sorted on a single column regular click on different column changes sort to that column with no grouped row
    Given Prepare the grid with no existing sorting column for "fully load":
      | groupName | id | activity | status | isGroupRow |
      | group2    | f2 | s3       | t1     | False      |
      | group1    | f1 | s1       | t3     | False      |
      | group4    | f4 | s4       | t5     | False      |
      | group3    | f3 | s2       | t4     | False      |
      | group5    | f5 | s5       | t2     | False      |
    And The grid sorted as "ASC" by "Activity" column:
      | indicator | groupName | Id | Activity | Status |
      | +         | group1    | f1 | s1       | t3     |
      | +         | group3    | f3 | s2       | t4     |
      | +         | group2    | f2 | s3       | t1     |
      | +         | group4    | f4 | s4       | t5     |
      | +         | group5    | f5 | s5       | t2     |
    When Click to sort as "ASC" for column "Status"
    Then I see grouped rows:
      | indicator | groupName | Id | Activity | Status |
      | +         | group2    | f2 | s3       | t1     |
      | +         | group5    | f5 | s5       | t2     |
      | +         | group1    | f1 | s1       | t3     |
      | +         | group3    | f3 | s2       | t4     |
      | +         | group4    | f4 | s4       | t5     |
    And The "Activity" column sort indicator should be "none"
    And The "Status" column sort indicator should be "asc"

  Scenario: Data sorted on a single column regular click on different column changes sort to that column with grouped row fully load
    Given Prepare the grid with no existing sorting column for "fully load":
      | groupName   | id   | activity | status | isGroupRow |
      | group1      | f1   | s1       | t1     | True       |
      | group1-chd2 | f1-2 | s1-3     | t1-1   | False      |
      | group1-chd1 | f1-1 | s1-1     | t1-3   | False      |
      | group1-chd4 | f1-4 | s1-4     | t1-5   | False      |
      | group1-chd3 | f1-3 | s1-2     | t1-4   | False      |
      | group1-chd5 | f1-5 | s1-5     | t1-2   | False      |
      | group2      | f2   | s2       | t2     | True       |
    And Click "expand" for row "group1"
    And The grid sorted as "ASC" by "Activity" column:
      | indicator | groupName | Id   | Activity | Status |
      | -         | group1    | f1   | s1       | t1     |
      |           | group1-1  | f1-1 | s1-1     | t1-3   |
      |           | group1-3  | f1-3 | s1-2     | t1-4   |
      |           | group1-2  | f1-2 | s1-3     | t1-1   |
      |           | group1-4  | f1-4 | s1-4     | t1-5   |
      |           | group1-5  | f1-5 | s1-5     | t1-2   |
      | +         | group2    | f2   | s2       | t2     |
    When Click to sort as "ASC" for column "Status"
    Then I see grouped rows:
      | indicator | groupName | Id   | Activity | Status |
      | -         | group1    | f1   | s1       | t1     |
      |           | group1-2  | f1-2 | s1-3     | t1-1   |
      |           | group1-5  | f1-5 | s1-5     | t1-2   |
      |           | group1-1  | f1-1 | s1-1     | t1-3   |
      |           | group1-3  | f1-3 | s1-2     | t1-4   |
      |           | group1-4  | f1-4 | s1-4     | t1-5   |
      | +         | group2    | f2   | s2       | t2     |
    And The "Activity" column sort indicator should be "none"
    And The "Status" column sort indicator should be "asc"

  Scenario: Data sorted on a single column regular click on different column changes sort to that column with grouped row partial load
    Given Prepare the grid with no existing sorting column for "lazily load":
      | groupName                                               | id           | activity     | status       |
      | accountSection[1]-accountType[1]-accountCode[1,3,2,4,5] | f[1,3,2,4,5] | s[1,2,3,4,5] | t[3,4,1,5,5] |
    And Click "expand" for row "f1"
    And Click "expand" for row "f1-1"
    And The grid sorted as "ASC" by "Activity" column:
      | indicator | groupName | Id     | Activity | Status |
      | -         | f1        | f1     | s1       | t1     |
      | -         | f1-1      | f1-1   | s1-1     | t1-1   |
      |           | f1-1-1    | f1-1-1 | s1-1-1   | t1-1-3 |
      |           | f1-1-3    | f1-1-3 | s1-1-2   | t1-1-4 |
      |           | f1-1-2    | f1-1-2 | s1-1-3   | t1-1-1 |
      |           | f1-1-4    | f1-1-4 | s1-1-4   | t1-1-5 |
      |           | f1-1-5    | f1-1-5 | s1-1-5   | t1-1-2 |
    When Click to sort as "ASC" for column "Status"
    Then I see grouped rows:
      | indicator | groupName | Id     | Activity | Status |
      | -         | 1         | f1     | s1       | t1     |
      | -         | f1-1      | f1-1   | s1-1     | t1-1   |
      |           | f1-1-2    | f1-1-2 | s1-1-3   | t1-1-1 |
      |           | f1-1-5    | f1-1-5 | s1-1-5   | t1-1-2 |
      |           | f1-1-1    | f1-1-1 | s1-1-1   | t1-1-3 |
      |           | f1-1-3    | f1-1-3 | s1-1-2   | t1-1-4 |
      |           | f1-1-4    | f1-1-4 | s1-1-4   | t1-1-5 |
    And The "Activity" column sort indicator should be "none"
    And The "Status" column sort indicator should be "asc"


  @wip
  Scenario: Data sorted on a single column control/command click on different column adds the column to the sort then regular click different column with no grouped row
    Given Prepare the grid with no existing sorting column for "fully load":
      | groupName | id | activity | status | use | sector | isGroupRow |
      | group1    | f1 | s2       | t1     | fo4 | fi5    | True       |
      | group2    | f2 | s1       | t3     | fo1 | fi2    | True       |
      | group3    | f3 | s2       | t5     | fo3 | fi1    | True       |
      | group4    | f4 | s2       | t1     | fo2 | fi3    | True       |
      | group5    | f5 | s3       | t2     | fo5 | fi4    | True       |
    And The grid sorted as "ASC" by "Activity" column:
      | indicator | groupName | Id | Activity | Status | Use | Sector |
      | +         | group2    | f2 | s1       | t3     | fo1 | fi2    |
      | +         | group1    | f1 | s2       | t1     | fo4 | fi5    |
      | +         | group3    | f3 | s2       | t5     | fo3 | fi1    |
      | +         | group4    | f4 | s2       | t1     | fo2 | fi3    |
      | +         | group5    | f5 | s3       | t2     | fo5 | fi4    |
    When "command" click to sort as "ASC" for column "Status"
    Then I see grouped rows:
      | indicator | groupName | Id | Activity | Status | Use | Sector |
      | +         | group2    | f2 | s1       | t3     | fo1 | fi2    |
      | +         | group1    | f1 | s2       | t1     | fo4 | fi5    |
      | +         | group4    | f4 | s2       | t1     | fo2 | fi3    |
      | +         | group3    | f3 | s2       | t5     | fo3 | fi1    |
      | +         | group5    | f5 | s3       | t2     | fo5 | fi4    |
    And The "Activity" column sort indicator should be "asc"
    And The "Status" column sort indicator should be "asc"

    Given Prepare the grid with no existing sorting column for "fully load":
      | groupName | id | activity | status | use | sector | isGroupRow |
      | group1    | f1 | s2       | t1     | fo4 | fi5    | True       |
      | group2    | f2 | s1       | t3     | fo1 | fi2    | True       |
      | group3    | f3 | s2       | t5     | fo3 | fi1    | True       |
      | group4    | f4 | s2       | t1     | fo2 | fi3    | True       |
      | group5    | f5 | s3       | t2     | fo5 | fi4    | True       |
    And The grid sorted as "ASC" by "Activity, Status" columns:
      | indicator | groupName | Id | Activity | Status | Use | Sector |
      | +         | group2    | f2 | s1       | t3     | fo1 | fi2    |
      | +         | group1    | f1 | s2       | t1     | fo4 | fi5    |
      | +         | group4    | f4 | s2       | t1     | fo2 | fi3    |
      | +         | group3    | f3 | s2       | t5     | fo3 | fi1    |
      | +         | group5    | f5 | s3       | t2     | fo5 | fi4    |
    When "command" click to sort as "ASC" for column "Use"
    Then I see grouped rows:
      | indicator | groupName | Id | Activity | Status | Use | Sector |
      | +         | group2    | f2 | s1       | t3     | fo1 | fi2    |
      | +         | group4    | f4 | s2       | t1     | fo2 | fi3    |
      | +         | group1    | f1 | s2       | t1     | fo4 | fi5    |
      | +         | group3    | f3 | s2       | t5     | fo3 | fi1    |
      | +         | group5    | f5 | s3       | t2     | fo5 | fi4    |
    And The "Activity" column sort indicator should be "asc"
    And The "Status" column sort indicator should be "asc"
    And The "Use" column sort indicator should be "asc"

    Given Prepare the grid with no existing sorting column for "fully load":
      | groupName | id | activity | status | use | sector | isGroupRow |
      | group1    | f1 | s2       | t1     | fo4 | fi5    | True       |
      | group2    | f2 | s1       | t3     | fo1 | fi2    | True       |
      | group3    | f3 | s2       | t5     | fo3 | fi1    | True       |
      | group4    | f4 | s2       | t1     | fo2 | fi3    | True       |
      | group5    | f5 | s3       | t2     | fo5 | fi4    | True       |
    And The grid sorted as "ASC" by "Activity, Status, Use" columns:
      | indicator | groupName | Id | Activity | Status | Use | Sector |
      | +         | group2    | f2 | s1       | t3     | fo1 | fi2    |
      | +         | group4    | f4 | s2       | t1     | fo2 | fi3    |
      | +         | group1    | f1 | s2       | t1     | fo4 | fi5    |
      | +         | group3    | f3 | s2       | t5     | fo3 | fi1    |
      | +         | group5    | f5 | s3       | t2     | fo5 | fi4    |
    When Click to sort as "ASC" for column "Sector"
    Then I see grouped rows:
      | indicator | groupName | Id | Activity | Status | Use | Sector |
      | +         | group3    | f3 | s2       | t5     | fo3 | fi1    |
      | +         | group2    | f2 | s1       | t3     | fo1 | fi2    |
      | +         | group4    | f4 | s2       | t1     | fo2 | fi3    |
      | +         | group1    | f1 | s3       | t2     | fo5 | fi4    |
      | +         | group5    | f5 | s2       | t1     | fo4 | fi5    |
    And The "Activity" column sort indicator should be "none"
    And The "Status" column sort indicator should be "none"
    And The "Use" column sort indicator should be "none"
    And The "Sector" column sort indicator should be "asc"

  @wip
  Scenario: Data sorted on a single column control/command click on different column adds the column to the sort then regular click different column with grouped row fully load
    Given Prepare the grid with no existing sorting column for "fully load":
      | groupName   | id   | activity | status | use   | sector | isGroupRow |
      | group1      | f1   | s1       | t1     | fo1   | fi1    | True       |
      | group1-chd1 | f1-1 | s1-2     | t1-1   | fo1-4 | fi1-5  | False      |
      | group1-chd2 | f1-2 | s1-1     | t1-3   | fo1-1 | fi1-2  | False      |
      | group1-chd3 | f1-3 | s1-2     | t1-5   | fo1-3 | fi1-1  | False      |
      | group1-chd4 | f1-4 | s1-2     | t1-1   | fo1-2 | fi1-3  | False      |
      | group1-chd5 | f1-5 | s1-3     | t1-2   | fo1-5 | fi1-4  | False      |
    And Click "expand" for row "group1"
    And The grid sorted as "ASC" by "Activity" column:
      | indicator | groupName   | Id   | Activity | Status | Use   | Sector |
      | -         | group1      | f1   | s1       | t1     | fo1   | fi1    |
      |           | group1-chd2 | f1-2 | s1-1     | t1-3   | fo1-1 | fi1-2  |
      |           | group1-chd1 | f1-1 | s1-2     | t1-1   | fo1-4 | fi1-5  |
      |           | group1-chd3 | f1-3 | s1-2     | t1-5   | fo1-3 | fi1-1  |
      |           | group1-chd4 | f1-4 | s1-2     | t1-1   | fo1-2 | fi1-3  |
      |           | group1-chd5 | f1-5 | s1-3     | t1-2   | fo1-5 | fi1-4  |
    When "command" click to sort as "ASC" for column "Status"
    Then I see grouped rows:
      | indicator | groupName   | Id   | Activity | Status | Use   | Sector |
      | -         | group1      | f1   | s1       | t1     | fo1   | fi1    |
      |           | group1-chd2 | f1-2 | s1-1     | t1-3   | fo1-1 | fi1-2  |
      |           | group1-chd1 | f1-1 | s1-2     | t1-1   | fo1-4 | fi1-5  |
      |           | group1-chd4 | f1-4 | s1-2     | t1-1   | fo1-2 | fi1-3  |
      |           | group1-chd3 | f1-3 | s1-2     | t1-5   | fo1-3 | fi1-1  |
      |           | group1-chd5 | f1-5 | s1-3     | t1-2   | fo1-5 | fi1-4  |
    And The "Activity" column sort indicator should be "asc"
    And The "Status" column sort indicator should be "asc"

    Given Prepare the grid with no existing sorting column for "fully load":
      | groupName   | id   | activity | status | use   | sector | isGroupRow |
      | group1      | f1   | s1       | t1     | fo1   | fi1    | True       |
      | group1-chd1 | f1-1 | s1-2     | t1-1   | fo1-4 | fi1-5  | False      |
      | group1-chd2 | f1-2 | s1-1     | t1-3   | fo1-1 | fi1-2  | False      |
      | group1-chd3 | f1-3 | s1-2     | t1-5   | fo1-3 | fi1-1  | False      |
      | group1-chd4 | f1-4 | s1-2     | t1-1   | fo1-2 | fi1-3  | False      |
      | group1-chd5 | f1-5 | s1-3     | t1-2   | fo1-5 | fi1-4  | False      |
    And Click "expand" for row "group1"
    And The grid sorted as "ASC" by "Activity, Status" columns:
      | indicator | groupName   | Id   | Activity | Status | Use   | Sector |
      | -         | group1      | f1   | s1       | t1     | fo1   | fi1    |
      |           | group1-chd2 | f1-2 | s1-1     | t1-3   | fo1-1 | fi1-2  |
      |           | group1-chd1 | f1-1 | s1-2     | t1-1   | fo1-4 | fi1-5  |
      |           | group1-chd4 | f1-4 | s1-2     | t1-1   | fo1-2 | fi1-3  |
      |           | group1-chd3 | f1-3 | s1-2     | t1-5   | fo1-3 | fi1-1  |
      |           | group1-chd5 | f1-5 | s1-3     | t1-2   | fo1-5 | fi1-4  |
    When "command" click to sort as "ASC" for column "Use"
    Then I see grouped rows:
      | indicator | groupName   | Id   | Activity | Status | Use   | Sector |
      | -         | group1      | f1   | s1       | t1     | fo1   | fi1    |
      |           | group1-chd2 | f1-2 | s1-1     | t1-3   | fo1-1 | fi1-2  |
      |           | group1-chd4 | f1-4 | s1-2     | t1-1   | fo1-2 | fi1-3  |
      |           | group1-chd1 | f1-1 | s1-2     | t1-1   | fo1-4 | fi1-5  |
      |           | group1-chd3 | f1-3 | s1-2     | t1-5   | fo1-3 | fi1-1  |
      |           | group1-chd5 | f1-5 | s1-3     | t1-2   | fo1-5 | fi1-4  |
    And The "Activity" column sort indicator should be "asc"
    And The "Status" column sort indicator should be "asc"
    And The "Use" column sort indicator should be "asc"

    Given Prepare the grid with no existing sorting column for "fully load":
      | groupName   | id   | activity | status | use   | sector | isGroupRow |
      | group1      | f1   | s1       | t1     | fo1   | fi1    | True       |
      | group1-chd1 | f1-1 | s1-2     | t1-1   | fo1-4 | fi1-5  | False      |
      | group1-chd2 | f1-2 | s1-1     | t1-3   | fo1-1 | fi1-2  | False      |
      | group1-chd3 | f1-3 | s1-2     | t1-5   | fo1-3 | fi1-1  | False      |
      | group1-chd4 | f1-4 | s1-2     | t1-1   | fo1-2 | fi1-3  | False      |
      | group1-chd5 | f1-5 | s1-3     | t1-2   | fo1-5 | fi1-4  | False      |
    And Click "expand" for row "group1"
    And The grid sorted as "ASC" by "Activity, Status, Use" columns:
      | indicator | groupName | Id   | Activity | Status | Use  | Sector |
      | -         | group1    | f1   | s1       | t1     | fo1  | fi1    |
      |           | group1-2  | f1-2 | s1-1     | t-3    | fo-1 | fi-2   |
      |           | group1-4  | f1-4 | s1-2     | t-1    | fo-2 | fi-3   |
      |           | group1-1  | f1-1 | s1-2     | t-1    | fo-4 | fi-5   |
      |           | group1-3  | f1-3 | s1-2     | t-5    | fo-3 | fi-1   |
      |           | group1-5  | f1-5 | s1-3     | t-2    | fo-5 | fi-4   |
    When Click to sort as "ASC" for column "Sector"
    Then I see grouped rows:
      | indicator | groupName | Id   | Activity | Status | Use   | Sector |
      | -         | group1    | f1   | s1       | t1     | fo1   | fi1    |
      |           | group1-3  | f1-3 | s1-2     | t1-5   | fo1-3 | fi1-1  |
      |           | group1-2  | f1-2 | s1-1     | t1-3   | fo1-1 | fi1-2  |
      |           | group1-4  | f1-4 | s1-2     | t1-1   | fo1-2 | fi1-3  |
      |           | group1-1  | f1-1 | s1-3     | t1-2   | fo1-5 | fi1-4  |
      |           | group1-5  | f1-5 | s1-2     | t1-1   | fo1-4 | fi1-5  |
    And The "Activity" column sort indicator should be "none"
    And The "Status" column sort indicator should be "none"
    And The "Use" column sort indicator should be "none"
    And The "Sector" column sort indicator should be "asc"

  @wip
  Scenario: Data sorted on a single column control/command click on different column adds the column to the sort then regular click different column with grouped row partial load
    Given Prepare the grid with no existing sorting column for "lazily load":
      | groupName                                               | id           | activity     | status       | use           | sector        |
      | accountSection[1]-accountType[1]-accountCode[1,2,3,4,5] | f[1,2,3,4,5] | s[2,1,2,2,3] | t[1,3,5,1,2] | fo[4,1,3,2,5] | fi[5,2,1,3,4] |
    And Click "expand" for row "f1"
    And Click "expand" for row "f1-1"
    And The grid sorted as "ASC" by "Activity" column:
      | indicator | groupName | Id     | Activity | Status | Use     | Sector  |
      | -         | f1        | f1     | s1       | t1     | fo1     | fi1     |
      | -         | f1-1      | f1-1   | s1-1     | t1-1   | fo1-1   | fi1-1   |
      |           | f1-1-2    | f1-1-2 | s1-1-1   | t1-1-3 | fo1-1-1 | fi1-1-2 |
      |           | f1-1-1    | f1-1-1 | s1-1-2   | t1-1-1 | fo1-1-4 | fi1-1-5 |
      |           | f1-1-3    | f1-1-3 | s1-1-2   | t1-1-5 | fo1-1-3 | fi1-1-1 |
      |           | f1-1-4    | f1-1-4 | s1-1-2   | t1-1-1 | fo1-1-2 | fi1-1-3 |
      |           | f1-1-5    | f1-1-5 | s1-1-3   | t1-1-2 | fo1-1-5 | fi1-1-4 |
    When "command" click to sort as "ASC" for column "Status"
    Then I see grouped rows:
      | indicator | groupName | Id     | Activity | Status | Use     | Sector  |
      | -         | f1        | f1     | s1       | t1     | fo1     | fi1     |
      | -         | f1-1      | f1-1   | s1-1     | t1-1   | fo1-1   | fi1-1   |
      |           | f1-1-2    | f1-1-2 | s1-1-1   | t1-1-3 | fo1-1-1 | fi1-1-2 |
      |           | f1-1-1    | f1-1-1 | s1-1-2   | t1-1-1 | fo1-1-4 | fi1-1-5 |
      |           | f1-1-4    | f1-1-4 | s1-1-2   | t1-1-1 | fo1-1-2 | fi1-1-3 |
      |           | f1-1-3    | f1-1-3 | s1-1-2   | t1-1-5 | fo1-1-3 | fi1-1-1 |
      |           | f1-1-5    | f1-1-5 | s1-1-3   | t1-1-2 | fo1-1-5 | fi1-1-4 |
    And The "Activity" column sort indicator should be "asc"
    And The "Status" column sort indicator should be "asc"

    Given Prepare the grid with no existing sorting column for "fully load":
      | groupName   | id   | activity | status | use   | sector | isGroupRow |
      | group1      | f1   | s1       | t1     | fo1   | fi1    | True       |
      | group1-chd1 | f1-1 | s1-2     | t1-1   | fo1-4 | fi1-5  | False      |
      | group1-chd2 | f1-2 | s1-1     | t1-3   | fo1-1 | fi1-2  | False      |
      | group1-chd3 | f1-3 | s1-2     | t1-5   | fo1-3 | fi1-1  | False      |
      | group1-chd4 | f1-4 | s1-2     | t1-1   | fo1-2 | fi1-3  | False      |
      | group1-chd5 | f1-5 | s1-3     | t1-2   | fo1-5 | fi1-4  | False      |
    And Click "expand" for row "f1"
    And Click "expand" for row "f1-1"
    And The grid sorted as "ASC" by "Activity, Status" columns:
      | indicator | groupName   | Id   | Activity | Status | Use   | Sector |
      | -         | group1      | f1   | s1       | t1     | fo1   | fi1    |
      |           | group1-chd2 | f1-2 | s1-1     | t1-3   | fo1-1 | fi1-2  |
      |           | group1-chd1 | f1-1 | s1-2     | t1-1   | fo1-4 | fi1-5  |
      |           | group1-chd4 | f1-4 | s1-2     | t1-1   | fo1-2 | fi1-3  |
      |           | group1-chd3 | f1-3 | s1-2     | t1-5   | fo1-3 | fi1-1  |
      |           | group1-chd5 | f1-5 | s1-3     | t1-2   | fo1-5 | fi1-4  |
    When "command" click to sort as "ASC" for column "Use"
    Then I see grouped rows:
      | indicator | groupName   | Id   | Activity | Status | Use   | Sector |
      | -         | group1      | f1   | s1       | t1     | fo1   | fi1    |
      |           | group1-chd2 | f1-2 | s1-1     | t1-3   | fo1-1 | fi1-2  |
      |           | group1-chd4 | f1-4 | s1-2     | t1-1   | fo1-2 | fi1-3  |
      |           | group1-chd1 | f1-1 | s1-2     | t1-1   | fo1-4 | fi1-5  |
      |           | group1-chd3 | f1-3 | s1-2     | t1-5   | fo1-3 | fi1-1  |
      |           | group1-chd5 | f1-5 | s1-3     | t1-2   | fo1-5 | fi1-4  |
    And The "Activity" column sort indicator should be "asc"
    And The "Status" column sort indicator should be "asc"
    And The "Use" column sort indicator should be "asc"

    Given Prepare the grid with no existing sorting column for "fully load":
      | groupName   | id   | activity | status | use   | sector | isGroupRow |
      | group1      | f1   | s1       | t1     | fo1   | fi1    | True       |
      | group1-chd1 | f1-1 | s1-2     | t1-1   | fo1-4 | fi1-5  | False      |
      | group1-chd2 | f1-2 | s1-1     | t1-3   | fo1-1 | fi1-2  | False      |
      | group1-chd3 | f1-3 | s1-2     | t1-5   | fo1-3 | fi1-1  | False      |
      | group1-chd4 | f1-4 | s1-2     | t1-1   | fo1-2 | fi1-3  | False      |
      | group1-chd5 | f1-5 | s1-3     | t1-2   | fo1-5 | fi1-4  | False      |
    And The grid sorted as "ASC" by "Activity, Status, Use" columns:
      | indicator | groupName | Id   | Activity | Status | Use  | Sector |
      | -         | group1    | f1   | s1       | t1     | fo1  | fi1    |
      |           | group1-2  | f1-2 | s1-1     | t-3    | fo-1 | fi-2   |
      |           | group1-4  | f1-4 | s1-2     | t-1    | fo-2 | fi-3   |
      |           | group1-1  | f1-1 | s1-2     | t-1    | fo-4 | fi-5   |
      |           | group1-3  | f1-3 | s1-2     | t-5    | fo-3 | fi-1   |
      |           | group1-5  | f1-5 | s1-3     | t-2    | fo-5 | fi-4   |
    When Click to sort as "ASC" for column "Sector"
    Then I see grouped rows:
      | indicator | groupName | Id   | Activity | Status | Use   | Sector |
      | -         | group1    | f1   | s1       | t1     | fo1   | fi1    |
      |           | group1-3  | f1-3 | s1-2     | t1-5   | fo1-3 | fi1-1  |
      |           | group1-2  | f1-2 | s1-1     | t1-3   | fo1-1 | fi1-2  |
      |           | group1-4  | f1-4 | s1-2     | t1-1   | fo1-2 | fi1-3  |
      |           | group1-1  | f1-1 | s1-3     | t1-2   | fo1-5 | fi1-4  |
      |           | group1-5  | f1-5 | s1-2     | t1-1   | fo1-4 | fi1-5  |
    And The "Activity" column sort indicator should be "none"
    And The "Status" column sort indicator should be "none"
    And The "Use" column sort indicator should be "none"
    And The "Sector" column sort indicator should be "asc"

  @wip
  Scenario: Data sorted on a multiple columns regular click on existing column toggles direction for that column then remove column from sort
    Given Prepare the grid with no existing sorting column:
      | groupName | id | activity | status | use | sector | isGroupRow |
      | group1    | f1 | s2       | t1     | fo4 | fi5    | True       |
      | group2    | f2 | s1       | t3     | fo1 | fi2    | True       |
      | group3    | f3 | s2       | t5     | fo3 | fi1    | True       |
      | group4    | f4 | s2       | t1     | fo2 | fi3    | True       |
      | group5    | f5 | s3       | t2     | fo5 | fi4    | True       |
    And The grid sorted as "ASC" by "Activity, Status" columns:
      | indicator | groupName | Id | Activity | Status | Use | Sector |
      | +         | group2    | f2 | s1       | t3     | fo1 | fi2    |
      | +         | group1    | f1 | s2       | t1     | fo4 | fi5    |
      | +         | group4    | f4 | s2       | t1     | fo2 | fi3    |
      | +         | group3    | f3 | s2       | t5     | fo3 | fi1    |
      | +         | group5    | f5 | s3       | t2     | fo5 | fi4    |
    When Click to sort as "DESC" for column "Activity"
    Then I see grouped rows:
      | indicator | groupName | Id | Activity | Status | Use | Sector |
      | +         | group5    | f5 | s3       | t2     | fo5 | fi4    |
      | +         | group1    | f1 | s2       | t1     | fo4 | fi5    |
      | +         | group4    | f4 | s2       | t1     | fo2 | fi3    |
      | +         | group3    | f3 | s2       | t5     | fo3 | fi1    |
      | +         | group2    | f2 | s1       | t3     | fo1 | fi2    |
    And The "Activity" column sort indicator should be "desc"
    And The "Status" column sort indicator should be "asc"

    Given Prepare the grid with no existing sorting column:
      | groupName | id | activity | status | use | sector | isGroupRow |
      | group1    | f1 | s2       | t1     | fo4 | fi5    | True       |
      | group2    | f2 | s1       | t3     | fo1 | fi2    | True       |
      | group3    | f3 | s2       | t5     | fo3 | fi1    | True       |
      | group4    | f4 | s2       | t1     | fo2 | fi3    | True       |
      | group5    | f5 | s3       | t2     | fo5 | fi4    | True       |
    And The grid sorted as "ASC" by "Activity, Status" columns:
      | indicator | groupName | Id | Activity | Status | Use | Sector |
      | +         | group2    | f2 | s1       | t3     | fo1 | fi2    |
      | +         | group1    | f1 | s2       | t1     | fo4 | fi5    |
      | +         | group4    | f4 | s2       | t1     | fo2 | fi3    |
      | +         | group3    | f3 | s2       | t5     | fo3 | fi1    |
      | +         | group5    | f5 | s3       | t2     | fo5 | fi4    |
    When "command" click to sort as "remove" for column "Activity"
    Then I see grouped rows:
      | indicator | groupName | Id | Activity | Status | Use | Sector |
      | +         | group1    | f1 | s2       | t1     | fo4 | fi5    |
      | +         | group4    | f4 | s2       | t1     | fo2 | fi3    |
      | +         | group5    | f5 | s3       | t2     | fo5 | fi4    |
      | +         | group2    | f2 | s1       | t3     | fo1 | fi2    |
      | +         | group3    | f3 | s2       | t5     | fo3 | fi1    |
    And The "Activity" column sort indicator should be "none"
    And The "Status" column sort indicator should be "asc"