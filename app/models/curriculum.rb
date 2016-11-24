class Curriculum < ApplicationRecord
  enum tipo: [ :obrigatoria, :eletiva, :livre ]
  belongs_to :course
  belongs_to :subject
  has_and_belongs_to_many :users
  def mandatory?
    tipo == "obrigatoria"
  end
end
