class StaticPagesController < ApplicationController
  helper_method :grade_curricular, :pre_requisitos
  
  def index
  end
  
  def about
  end
  
  def contact
  end

  def grade_curricular
    @grade_curricular = {}
    for i in 1..current_user.course.duracao_ideal do
      @grade_curricular[i] = []
    end
    Curriculum.where(course: current_user.course).order(:semestre, :tipo).each do |cur|
      cur.subject.tipo = cur.mandatory? ? "mandatory" : "optional"
      @grade_curricular[cur.semestre] << cur.subject;
    end
    @grade_curricular
  end

  def pre_requisitos #group+concat?
    @pre_requisitos = {}
    Requisite.where(course: current_user.course).where.not(tipo: "conjunto").each do |req|
      @pre_requisitos[req.disciplina.codigo] ||= []
      @pre_requisitos[req.disciplina.codigo] << req.requisito.codigo
    end
    @pre_requisitos
  end
end
