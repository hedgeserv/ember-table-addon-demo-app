Feature: Column sort
  In order to get summary related information with certain sequence
  As a customer
  The columns should be sortable

  @complete
  Scenario: Sort individual column with completely loaded data
    Given There are 200 loans in chunk size 50
    When Presenting "column sort"
    Then Drag scroll bar to "bottom"
    And Click to sort a column as "ASC"
    And The "last" record should be "199"
    Then Click to sort a column as "DESC"
    And The "last" record should be "0"
    Then Drag scroll bar to "top"
    And The "first" record should be "199"

  @complete
  Scenario: Sort individual column with partial loaded data
    Given There are 200 sortable loans in chunk size 50
    When Presenting "column sort"
    Then There should be 2 sections loaded
    When Customer drags scroll bar by offset 60 with 1 times
    Then There should be 3 sections loaded
    And The "current" record should be "47"
    When Click to sort a column as "ASC"
    Then There should be 6 sections loaded
    When Click to sort a column as "DESC"
    Then There should be 9 sections loaded
    And The "current" record should be "152"

  @complete
  Scenario: Check sort indicator on column
    Given There are 200 sortable loans in chunk size 50
    When Presenting "column sort"
    Then The "Id" column sort indicator should be "none"
    When Click to sort a column as "ASC"
    Then The "Id" column sort indicator should be "asc"
    When Click to sort a column as "DESC"
    Then The "Id" column sort indicator should be "desc"