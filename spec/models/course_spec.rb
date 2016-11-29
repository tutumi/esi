require 'rails_helper'

RSpec.describe Course, type: :model do
  before :all do
    @course = Course.new(nome: "Redes", codcg: "5484", codcur: "20", codhab:"123", duracao_min: "20", duracao_ideal: "30", duracao_max: "40", ch_obrigatoria_aula: "40",
    ch_obrigatoria_trab: "20", ch_eletiva_aula: "5", ch_eletiva_trab: "2", ch_livre_aula: "1", ch_livre_trab: "1", ch_estagio: "20", periodo: "noturno") 
  end
  
  it "should destroy the course" do
    @course.delete
    expect { Course.find(@course.id) }.to raise_exception(ActiveRecord::RecordNotFound)
  end
  
  it "should be valid" do
    @course.delete
    expect(@course).to be_valid
  end
end
