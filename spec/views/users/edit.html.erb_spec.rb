require 'rails_helper'

RSpec.describe "users/edit", type: :view do
  before(:each) do
    @user = assign(:user, User.create!(
      :name => "Ana Carolina Trino de Carvalho",
      :email => "ana.trino.carvalho@usp.br",
      :nusp => "8641897",
      :password => "teste123",
      :course => Course.create({'nome' => 'Bacharelado em Educação Física e Saúde', 'codcg' => 9999, 'codcur' => 999999, 'codhab' => 999, 'duracao_min' => 8, 'duracao_ideal' => 8, 'duracao_max' => 12, 'ch_obrigatoria_aula' => 1830, 'ch_obrigatoria_trab' => 720, 'ch_eletiva_aula' => 240, 'ch_eletiva_trab' => 0, 'ch_livre_aula' => 750, 'ch_livre_trab' => 0, 'ch_estagio' => 480, 'periodo' => 'vespertino'}),
    ))
  end

  it "renders the edit user form" do
    render

    assert_select "form[action=?][method=?]", user_path(@user), "post" do
      assert_select "input#user_name[name=?]", "user[name]"
      assert_select "input#user_email[name=?]", "user[email]"
      assert_select "input#user_nusp[name=?]", "user[nusp]"
      assert_select "select#user_course_id[name=?]", "user[course_id]"
      assert_select "input#user_startYear[name=?]", "user[startYear]"
      assert_select "input#user_password[name=?]", "user[password]"
      assert_select "input#user_password_confirmation[name=?]", "user[password_confirmation]"
    end
    
    assert_select "input[type=submit]"
  end
end
