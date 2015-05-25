Feature: Column sort
  In order to get summary related information with certain sequence
  As a customer
  The columns should be sortable

  @wip
  Scenario: sort individual column
    Given There are 200 loans in chunk size 50
    When Presenting "column sort"
    Then Drag scroll bar to "bottom"
    And Click to sort a column as "ASC"
    Then Drag scroll bar to "top"
    And The "first" record should be "1892"
    Then Drag scroll bar to "bottom"
    And The "last" record should be "872295"
    Then Click to sort a column as DESC
    Then Drag scroll bar to "top"
    And The "first" record should be "872295"
    Then Drag scroll bar to "bottom"
    And The "last" record should be "1892"
