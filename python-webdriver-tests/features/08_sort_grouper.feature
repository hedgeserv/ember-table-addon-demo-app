Feature: Multi-Column Sorting
  In order to perform complex sorts on multi-column datasets
  As a user presented with a grid
  I need sorting on grouper

  @wip
  Scenario: grouper should be sorted by column sorting direction
    Given Prepare the grid with no existing sorting column for "grouper":
      | groupName                                           | id |
      | accountSection[3]-accountType[3]-accountCode[1,3,2] |    |
    When Click to sort as "ASC" for column "Id"
    And Click to sort as "DESC" for column "Id"
    Then I see grouped rows:
      | indicator | groupName | Id |
      | +         | 3         | 2  |
      | +         | 2         | 3  |
      | +         | 1         | 1  |

    Given Prepare the grid with no existing sorting column for "grouper":
      | groupName                                           | id      |
      | accountSection[3]-accountType[1]-accountCode[3,2,1] | [3,2,1] |
    And Click "expand" for row "3"
    And Click "expand" for row "301"
    And I see grouped rows:
      | indicator | groupName | Id    |
      | +         | 1         | 1     |
      | +         | 2         | 2     |
      | -         | 3         | 3     |
      | -         | 301       | 301   |
      | +         | 30103     | 30103 |
      | +         | 30102     | 30102 |
      | +         | 30101     | 30101 |
    When Click to sort as "ASC" for column "Id"
    And Click to sort as "DESC" for column "Id"
    Then I see grouped rows:
      | indicator | groupName | Id    |
      | -         | 3         | 3     |
      | -         | 301       | 301   |
      |           | 30102     | 30103 |
      |           | 30102     | 30102 |
      |           | 30101     | 30101 |
      | +         | 2         | 2     |
      | +         | 1         | 1     |

  @wip
  Scenario: Sort by first grouper level
    Given Prepare the grid with no existing sorting column for "grouper":
      | groupName                                           | id      |
      | accountSection[3]-accountType[1]-accountCode[3,2,1] | [3,2,1] |
    When Click grouper "Account Section" to sort as "ASC"
    Then I see grouped rows:
      | indicator | groupName | Id    |
      | +         | 1         | 1     |
      | +         | 2         | 2     |
      | -         | 3         | 3     |
      | -         | 301       | 301   |
      | +         | 30103     | 30103 |
      | +         | 30102     | 30102 |
      | +         | 30101     | 30101 |

    Given Prepare the grid with no existing sorting column for "grouper":
      | groupName                                           | id      |
      | accountSection[3]-accountType[2]-accountCode[3,2,1] | [3,2,1] |
    When Click grouper "Account Section" to sort as "DESC"
    Then I see grouped rows:
      | indicator | groupName | Id    |
      | -         | 3         | 3     |
      | -         | 301       | 301   |
      | +         | 30103     | 30103 |
      | +         | 30102     | 30102 |
      | +         | 30101     | 30101 |
      | +         | 302       | 302   |
      | +         | 2         | 2     |
      | +         | 1         | 1     |