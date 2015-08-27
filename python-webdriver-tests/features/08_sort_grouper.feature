Feature: Multi-Column Sorting
  In order to perform complex sorts on multi-column datasets
  As a user presented with a grid
  I need sorting on grouper

  @complete
  Scenario: Grouper should be sorted by column sorting direction
    Given Prepare the grid with no existing sorting column for "grouper":
      | groupName                                           | id |
      | accountSection[3]-accountType[3]-accountCode[1,3,2] |    |
    When Click to sort as "ASC" for column "Id"
    And Click to sort as "DESC" for column "Id"
    Then I see grouped rows:
      | indicator | groupName | Id |
      | +         | 3         | 3  |
      | +         | 2         | 2  |
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
      |           | 30103     | 30103 |
      |           | 30102     | 30102 |
      |           | 30101     | 30101 |
    When Click to sort as "ASC" for column "Id"
    And Click to sort as "DESC" for column "Id"
    Then I see grouped rows:
      | indicator | groupName | Id    |
      | -         | 3         | 3     |
      | -         | 301       | 301   |
      |           | 30103     | 30103 |
      |           | 30102     | 30102 |
      |           | 30101     | 30101 |
      | +         | 2         | 2     |
      | +         | 1         | 1     |

  @complete
  Scenario: Sort by first grouper level
    Given Prepare the grid with no existing sorting column for "grouper":
      | groupName                                           | id      |
      | accountSection[3]-accountType[1]-accountCode[3,2,1] | [3,2,1] |
    When Click grouper "accountSection" to sort as "ASC"
    And Click "expand" for row "3"
    And Click "expand" for row "301"
    Then I see grouped rows:
      | indicator | groupName | Id    |
      | +         | 1         | 1     |
      | +         | 2         | 2     |
      | -         | 3         | 3     |
      | -         | 301       | 301   |
      |           | 30103     | 30103 |
      |           | 30102     | 30102 |
      |           | 30101     | 30101 |

    Given Prepare the grid with no existing sorting column for "grouper":
      | groupName                                           | id      |
      | accountSection[3]-accountType[2]-accountCode[3,2,1] | [3,2,1] |
    When Click grouper "accountSection" to sort as "DESC"
    And Click "expand" for row "3"
    And Click "expand" for row "301"
    Then I see grouped rows:
      | indicator | groupName | Id    |
      | -         | 3         | 3     |
      | -         | 301       | 301   |
      |           | 30103     | 30103 |
      |           | 30102     | 30102 |
      |           | 30101     | 30101 |
      | +         | 302       | 302   |
      | +         | 2         | 2     |
      | +         | 1         | 1     |

  @complete
  Scenario: Sort by first and second grouper level
    Given Prepare the grid with no existing sorting column for "grouper":
      | groupName                                         | id    |
      | accountSection[2]-accountType[2]-accountCode[3,2] | [3,2] |
    When Click grouper "accountSection" to sort as "DESC"
    And Click grouper "accountType" to sort as "ASC"
    And Click "expand" for row "2"
    And Click "expand" for row "201"
    Then I see grouped rows:
      | indicator | groupName | Id    |
      | -         | 2         | 2     |
      | -         | 201       | 201   |
      |           | 20103     | 20103 |
      |           | 20102     | 20102 |
      | +         | 202       | 202   |
      | +         | 1         | 1     |

    Given Prepare the grid with no existing sorting column for "grouper":
      | groupName                                         | id    |
      | accountSection[2]-accountType[2]-accountCode[1,2] | [1,2] |
    When Click grouper "accountSection" to sort as "DESC"
    And Click grouper "accountType" to sort as "DESC"
    And Click "expand" for row "2"
    And Click "expand" for row "202"
    Then I see grouped rows:
      | indicator | groupName | Id    |
      | -         | 2         | 2     |
      | -         | 202       | 202   |
      |           | 20201     | 20201 |
      |           | 20202     | 20202 |
      | +         | 201       | 201   |
      | +         | 1         | 1     |

    Given Prepare the grid with no existing sorting column for "grouper":
      | groupName                                         | id    |
      | accountSection[2]-accountType[2]-accountCode[1,2] | [1,2] |
    And Click "expand" for row "2"
    And Click "expand" for row "201"
    And I see grouped rows:
      | indicator | groupName | Id    |
      | +         | 1         | 1     |
      | -         | 2         | 2     |
      | -         | 201       | 201   |
      |           | 20101     | 20101 |
      |           | 20102     | 20102 |
      | +         | 202       | 202   |
    When Click grouper "accountSection" to sort as "DESC"
    And Click grouper "accountType" to sort as "DESC"
    And I see grouped rows:
      | indicator | groupName | Id    |
      | -         | 2         | 2     |
      | +         | 202       | 202   |
      | -         | 201       | 201   |
      |           | 20101     | 20101 |
      |           | 20102     | 20102 |
      | +         | 1         | 1     |


  @complete
  Scenario: Sort by first, second and third grouper level
    Given Prepare the grid with no existing sorting column for "grouper":
      | groupName                                         | id    |
      | accountSection[2]-accountType[2]-accountCode[3,2] | [3,2] |
    When Click grouper "accountSection" to sort as "DESC"
    And Click grouper "accountType" to sort as "ASC"
    And Click grouper "accountCode" to sort as "ASC"
    And Click "expand" for row "2"
    And Click "expand" for row "201"
    Then I see grouped rows:
      | indicator | groupName | Id    |
      | -         | 2         | 2     |
      | -         | 201       | 201   |
      |           | 20102     | 20102 |
      |           | 20103     | 20103 |
      | +         | 202       | 202   |
      | +         | 1         | 1     |

    Given Prepare the grid with no existing sorting column for "grouper":
      | groupName                                         | id    |
      | accountSection[2]-accountType[2]-accountCode[1,2] | [1,2] |
    When Click grouper "accountSection" to sort as "DESC"
    And Click grouper "accountType" to sort as "DESC"
    And Click grouper "accountCode" to sort as "DESC"
    And Click "expand" for row "2"
    And Click "expand" for row "202"
    Then I see grouped rows:
      | indicator | groupName | Id    |
      | -         | 2         | 2     |
      | -         | 202       | 202   |
      |           | 20202     | 20202 |
      |           | 20201     | 20201 |
      | +         | 201       | 201   |
      | +         | 1         | 1     |

    Given Prepare the grid with no existing sorting column for "grouper":
      | groupName                                         | id    |
      | accountSection[2]-accountType[2]-accountCode[1,2] | [1,2] |
    And Click "expand" for row "2"
    And Click "expand" for row "1"
    When Click grouper "accountSection" to sort as "DESC"
    Then I see grouped rows:
      | indicator | groupName | Id  |
      | -         | 2         | 2   |
      | +         | 201       | 201 |
      | +         | 202       | 202 |
      | -         | 1         | 1   |
      | +         | 101       | 101 |
      | +         | 102       | 102 |

  @complete
  Scenario: Sort by grouper level ans sorted column
    Given Prepare the grid with no existing sorting column for "grouper":
      | groupName                                         | id    |
      | accountSection[2]-accountType[2]-accountCode[1,2] | [1,2] |
    When Click "expand" for row "2"
    And Click "expand" for row "202"
    And Click grouper "accountSection" to sort as "DESC"
    And Click grouper "accountType" to sort as "DESC"
    And Click to sort as "ASC" for column "Id"
    And Click to sort as "DESC" for column "Id"
    Then I see grouped rows:
      | indicator | groupName | Id    |
      | -         | 2         | 2     |
      | -         | 202       | 202   |
      |           | 20202     | 20202 |
      |           | 20201     | 20201 |
      | +         | 201       | 201   |
      | +         | 1         | 1     |

    Given Prepare the grid with no existing sorting column for "grouper":
      | groupName                                         | id    |
      | accountSection[2]-accountType[2]-accountCode[2,1] | [1,2] |
    When Click "expand" for row "2"
    And Click "expand" for row "202"
    And Click grouper "accountSection" to sort as "DESC"
    And Click grouper "accountType" to sort as "DESC"
    And Click grouper "accountCode" to sort as "ASC"
    And Click to sort as "ASC" for column "Id"
    And Click to sort as "DESC" for column "Id"
    Then I see grouped rows:
      | indicator | groupName | Id    |
      | -         | 2         | 2     |
      | -         | 202       | 202   |
      |           | 20201     | 20201 |
      |           | 20202     | 20202 |
      | +         | 201       | 201   |
      | +         | 1         | 1     |
    And There should be 3 sections loaded

  @compete
  Scenario: Sort by grouper with unsort status
    Given Prepare the grid with no existing sorting column for "grouper":
      | groupName                                         | id    |
      | accountSection[2]-accountType[2]-accountCode[1,2] | [1,2] |
    When Click grouper "accountSection" to sort as "DESC"
    And Click grouper "accountType" to sort as "DESC"
    And Click "expand" for row "2"
    And Click "expand" for row "202"
    And Click grouper "accountType" to sort as "unsort"
    And Click grouper "accountCode" to sort as "ASC"
    And Click grouper "accountCode" to sort as "unsort"
    Then I see grouped rows:
      | indicator | groupName | Id    |
      | -         | 2         | 2     |
      | -         | 202       | 202   |
      |           | 20202     | 20202 |
      |           | 20201     | 20201 |
      | +         | 201       | 201   |
      | +         | 1         | 1     |

  @complete
  Scenario: Sort by grouper first level with partial loaded data
    Given Prepare the grid with no existing sorting column for "grouper":
      | groupName                                          | id |
      | accountSection[21]-accountType[21]-accountCode[21] |    |
    When Click grouper "accountSection" to sort as "ASC"
    And Click grouper "accountSection" to sort as "unsort"
    Then There should be 8 sections loaded
    And I see grouped rows:
      | indicator | groupName | Id |
      | +         | 1         | 1  |
      | +         | 2         | 2  |
      | +         | 3         | 3  |
      | +         | 4         | 4  |
      | +         | 5         | 5  |
      | +         | 6         | 6  |

#  The scenario tracks defect https://hedgeserv.leankit.com/Boards/View/200742377/237591318
  @wip
  Scenario: Sort by grouper by first and second level with partial load data
    Given Prepare the grid with no existing sorting column for "grouper":
      | groupName                                          | id |
      | accountSection[21]-accountType[21]-accountCode[11] |    |
    When Click "expand" for row "1"
    And Click "expand" for row "101"
    And Click grouper "accountSection" to sort as "ASC"
    And There should be 5 sections loaded
    And Click grouper "accountSection" to sort as "unsort"
    And There should be 8 sections loaded

  @complete
  Scenario: Check the expanded status should be kept after sort grouper
    Given Prepare the grid with no existing sorting column for "grouper":
      | groupName                                          | id |
      | accountSection[21]-accountType[21]-accountCode[11] |    |
    When Click "expand" for row "1"
    And Click "expand" for row "101"
    And Click grouper "accountSection" to sort as "DESC"
    And Customer drags scroll bar by offset 50 with 4 times and wait loading section
    And I see grouped rows:
      | indicator | groupName | Id    |
      | -         | 1         | 1     |
      | -         | 101       | 101   |
      |           | 10101     | 10101 |
      |           | 10102     | 10102 |
      |           | 10103     | 10103 |
      |           | 10104     | 10104 |
      |           | 10105     | 10105 |
      |           | 10106     | 10106 |



