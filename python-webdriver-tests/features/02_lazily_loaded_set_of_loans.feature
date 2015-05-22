Feature: Lazily Loaded Set of Loans
  In order to check loans data with good performance
  As a customer
  The page should load data lazily within certain number


  @complete
  Scenario: Show first and last section of loans
    Given There are 300 loans in chunk size 50
    Then Only first and last chunk was loaded in total 300 in first time

  @complete
  Scenario: Scroll bar to load other sections of loans
    Given There are 200 loans in chunk size 50
    Then Scroll bar by offset 60 with 2 times to load next chunks in total 200 and drag scroll bar to top without rerender