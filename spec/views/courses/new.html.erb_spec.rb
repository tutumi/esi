require 'rails_helper'

RSpec.describe "courses/new", type: :view do
  before(:each) do
    assign(:course, Course.new({'nome' => 'Bacharelado em Educação Física e Saúde', 'codcg' => 9999, 'codcur' => 999999, 'codhab' => 999, 'duracao_min' => 8, 'duracao_ideal' => 8, 'duracao_max' => 12, 'ch_obrigatoria_aula' => 1830, 'ch_obrigatoria_trab' => 720, 'ch_eletiva_aula' => 240, 'ch_eletiva_trab' => 0, 'ch_livre_aula' => 750, 'ch_livre_trab' => 0, 'ch_estagio' => 480, 'periodo' => 'vespertino'}))
  end

  it "renders new course form" do
    render

    assert_select "form[action=?][method=?]", courses_path, "post" do
    end
  end
end
