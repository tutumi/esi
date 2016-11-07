class Requisite < ApplicationRecord
  enum tipo: [ :fraco, :forte, :conjunto ]

  belongs_to :disciplina, foreign_key: "disciplina_id", class_name: "Subject"
  belongs_to :requisito, foreign_key: "requisito_id", class_name: "Subject"
  belongs_to :course
end
