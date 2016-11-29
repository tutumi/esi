Feature: User Logout
  As an user
  I want to logout from the site

Scenario: User logout
  Given I am registered
  And I am logged in
  When I follow "Log out"
  Then I should see "Entre na sua Conta"
 