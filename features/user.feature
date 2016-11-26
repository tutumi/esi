Feature: Create User
 In order to use the site
 As a user
 I want to create, update and destroy users

 
 Scenario: Create a valid user
   Given I have no user
   And I have some course
   And I go to login page
   When I follow "Sign up now!"
   And I fill in "Nome" with "Rodrigo"
   And I fill in "Email" with "eu@rodrigoguerra.com.br"
   And I fill in "Número USP" with "8516497"
   And I select "SI - (noturno)" from "Curso"
   And I fill in "Ano de Ingresso" with "2013"
   And I fill in "Senha" with "123456"
   And I fill in "Repita a senha" with "123456"
   And I press "Criar usuário"
   Then I should see "User was successfully created."
   And I should see "Rodrigo"
   And I should see "eu@rodrigoguerra.com.br"
   And I should have 1 user
