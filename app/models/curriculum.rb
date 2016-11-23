class Curriculum < ApplicationRecord
  enum tipo: [ :obrigatoria, :eletiva, :livre ]
  belongs_to :course
  belongs_to :subject

  def mandatory?
    tipo == "obrigatoria"
  end
end
