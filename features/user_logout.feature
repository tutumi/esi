Feature: User Logout
  As an user
  I want to logout from the site

Scenario: User logout
  Given I am registered
  When I go to the login page
  And I fill in "Email" with "sergio@tutumi.com.br"
  And I fill in "Password" with "senha123"
  And I press "Log in"
  Then I should see "Bem vindo, Sergio"
  When I go to the login page
 # And I press "Log out" - nao encontrando log out
 