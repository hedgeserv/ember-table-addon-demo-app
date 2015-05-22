Feature: Lazily Loaded Set of Loans
  In order to check loans data with good performance
  As a customer
  The page should load data lazily within certain number


  @complete
  Scenario: Show first section of loans
    Given There are 300 loans
    Then Only chunk was loaded in total 300