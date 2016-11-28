Feature: User Login
  As an user
  I want to login into the site
  In order to view my personal info

Scenario: User successfully logged in
  Given I am registered
  When I go to the login page
  And I fill in "Email" with "sergio@tutumi.com.br"
  And I fill in "Password" with "senha123"
  And I press "Log in"
  Then I should see "Bem vindo, Sergio"

Scenario: Invalid credentials not able to login
  Given I am on the login page
  And I fill in "Email" with "sergio@tutumi.com.br"
  And I fill in "Password" with "derp123"
  And I press "Log in"
  Then I should see "Email ou senha inválidos."
