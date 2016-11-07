class Subject < ApplicationRecord
  has_many :curriculums
  has_many :courses, through: :curriculums

  
  has_many :prereq, through: :req_prereq, source: :requisito
  has_many :req_prereq, foreign_key: :disciplina_id, class_name: "Requisite" 
  

  has_many :disciplinas, through: :disc_prereq, source: :disciplina
  has_many :disc_prereq, foreign_key: :requisito_id, class_name: "Requisite"      

end
