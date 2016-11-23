class StaticPagesController < ApplicationController
  helper_method :grade_curricular
  
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
    Curriculum.where(course: current_user.course).order(:semestre, :tipo).each do |c|
      c.subject.tipo = c.mandatory? ? "mandatory" : "optional"
      @grade_curricular[c.semestre] << c.subject;
    end
    @grade_curricular
  end
end
