require 'rails_helper'

RSpec.describe "sessions/new.html.erb", type: :view do
  
  let(:new_course){
    Course.create({'nome' => 'Bacharelado em Educação Física e Saúde', 'codcg' => 9999, 'codcur' => 999999, 'codhab' => 999, 'duracao_min' => 8, 'duracao_ideal' => 8, 'duracao_max' => 12, 'ch_obrigatoria_aula' => 1830, 'ch_obrigatoria_trab' => 720, 'ch_eletiva_aula' => 240, 'ch_eletiva_trab' => 0, 'ch_livre_aula' => 750, 'ch_livre_trab' => 0, 'ch_estagio' => 480, 'periodo' => 'vespertino'})
  }
  
  before(:each) do
    assign(:user, User.create({'name' => 'Bruno Murozaki', 'email' => 'brunomurozaki@email.com.br', 'nusp' => '0000004', 'password' => 'password', 'course_id' => new_course.id}))
  end

  it "renders new login form" do
    render

    assert_select "form[action=?][method=?]", login_path, "post" do
      assert_select "input#session_email"
      assert_select "input#session_password"
    end
    assert_select "input[type=submit]"
  end
  #pending "add some examples to (or delete) #{__FILE__}"
end
