Feature: Fully Loaded Set of Loans
  In order to check loans data load fully
  As a customer
  The page should load data fully within certain number

  @complete
  Scenario: Fully Loaded Set of Loans
    Given There are 1002 loans
    When Presenting "the list of loans"
    Then 1002 loans should be shown in a table, from the outset and
    And The page load time should be longer than ten seconds