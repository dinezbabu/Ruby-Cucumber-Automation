Feature: Search the internet for news
 In order to find news
 As an internet user
 I want to be able to search for news web sites

   Scenario: Search for news providers
     Given I am at google home page
#     And I enter "mobile" into the search bar
#     When I hit search
     When I get count and Ads url

  Scenario: Youtube
    Given I search for youtube
