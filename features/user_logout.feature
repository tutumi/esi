Feature: User Logout
  As an user
  I want to logout from the site

Scenario: User logout
  Given I am logged in
  When I go to the logout page
  And I press "logout"
  Then I should be redirect_to root_path