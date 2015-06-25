Feature: Multi-Column Sorting
  In order to perform complex sorts on multi-column datasets
  As a user presented with a grid
  I need an intuitive an set of controls to specify which columns to sort on

  @wip
  Scenario: Regular click when no existing sorting should sort ascending and then descending on column
    Given Prepare the grid with no existing sorting column:
      | groupName | id | activity | isGroupRow |
      | group2    | f2 | s2       | True       |
      | group1    | f1 | s1       | True       |
      | group4    | f4 | s4       | True       |
      | group3    | f3 | s3       | True       |
      | group5    | f5 | s5       | True       |
    When Click to sort as "ASC" for column "Activity"
    Then I see grouped rows:
      | indicator | groupName | Id | Activity |
      | +         | group1    | f1 | s1       |
      | +         | group2    | f2 | s2       |
      | +         | group3    | f3 | s3       |
      | +         | group4    | f4 | s4       |
      | +         | group5    | f5 | s5       |
    And The "Activity" column sort indicator should be "asc"

    Given The grid with no existing sorting column:
      | groupName | id | activity | isGroupRow |
      | group2    | f2 | s2       | True       |
      | group1    | f1 | s1       | True       |
      | group4    | f4 | s4       | True       |
      | group3    | f3 | s3       | True       |
      | group5    | f5 | s5       | True       |
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

    Given The grid with no existing sorting column:
      | groupName | id | activity | isGroupRow |
      | group2    | f2 | s2       | True       |
      | group1    | f1 | s1       | True       |
      | group4    | f4 | s4       | True       |
      | group3    | f3 | s3       | True       |
      | group5    | f5 | s5       | True       |
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
  Scenario: Control/Command click when no existing sorting should sort ascending and then descending on column
    Given Prepare the grid with no existing sorting column:
      | groupName | id | activity | isGroupRow |
      | group2    | f2 | s2       | True       |
      | group1    | f1 | s1       | True       |
      | group4    | f4 | s4       | True       |
      | group3    | f3 | s3       | True       |
      | group5    | f5 | s5       | True       |
    When "command" click to sort as "ASC" for column "Activity"
    Then I see grouped rows:
      | indicator | groupName | Id | Activity |
      | +         | group1    | f1 | s1       |
      | +         | group2    | f2 | s2       |
      | +         | group3    | f3 | s3       |
      | +         | group4    | f4 | s4       |
      | +         | group5    | f5 | s5       |
    And The "Activity" column sort indicator should be "asc"

    Given Prepare the grid with no existing sorting column:
      | groupName | id | activity | isGroupRow |
      | group2    | f2 | s2       | True       |
      | group1    | f1 | s1       | True       |
      | group4    | f4 | s4       | True       |
      | group3    | f3 | s3       | True       |
      | group5    | f5 | s5       | True       |
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

    Given Prepare the grid with no existing sorting column:
      | groupName | id | activity | isGroupRow |
      | group2    | f2 | s2       | True       |
      | group1    | f1 | s1       | True       |
      | group4    | f4 | s4       | True       |
      | group3    | f3 | s3       | True       |
      | group5    | f5 | s5       | True       |
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
  Scenario: Data sorted on a single column regular click on different column changes sort to that column
    Given Prepare the grid with no existing sorting column:
      | groupName | id | activity | status | isGroupRow |
      | group2    | f2 | s3       | t1     | True       |
      | group1    | f1 | s1       | t3     | True       |
      | group4    | f4 | s4       | t5     | True       |
      | group3    | f3 | s2       | t4     | True       |
      | group5    | f5 | s5       | t2     | True       |
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


  @wip
  Scenario: Data sorted on a single column control/command click on different column adds the column to the sort then regular click different column
    Given Prepare the grid with no existing sorting column:
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

    Given Prepare the grid with no existing sorting column:
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