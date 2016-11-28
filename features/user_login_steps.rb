Given(/^I am registered$/) do
  curso = Course.create({'nome' => 'SI', 'codcg' => 9999, 'codcur' => 999999, 'codhab' => 999, 'duracao_min' => 8, 'duracao_ideal' => 8, 'duracao_max' => 12, 'ch_obrigatoria_aula' => 1830, 'ch_obrigatoria_trab' => 720, 'ch_eletiva_aula' => 240, 'ch_eletiva_trab' => 0, 'ch_livre_aula' => 750, 'ch_livre_trab' => 0, 'ch_estagio' => 480, 'periodo' => 'noturno'})
  User.create('name' => 'Sergio Tutumi', 'email' => 'sergio@tutumi.com.br', 'nusp' => '123456', 'password' => 'senha123', 'course' => curso)
end