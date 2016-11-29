class Course < ApplicationRecord
  enum periodo: [ :matutino, :vespertino, :noturno, :integral ]
  has_many :curriculums
  has_many :subjects, through: :curriculums
  has_many :requisites
  has_many :users
  
  VALID_NAME_REGEX = /\A[^0-9`!@#\$%\^&*+_=]+\z/
  validates :nome, presence: true, length: {maximum: 100}, format: VALID_NAME_REGEX
  validates :codcg, presence: true, numericality: { only_integer: true }
  validates :codcur, presence: true, numericality: { only_integer: true }
  validates :codhab, presence: true, numericality: { only_integer: true }
  validates :duracao_min, presence: true, numericality: { only_integer: true }
  validates :duracao_ideal, presence: true, numericality: { only_integer: true }
  validates :duracao_max, presence: true, numericality: { only_integer: true }
  validates :ch_obrigatoria_aula, presence: true, numericality: { only_integer: true }
  validates :ch_obrigatoria_trab, presence: true, numericality: { only_integer: true }
  validates :ch_eletiva_aula, presence: true, numericality: { only_integer: true }
  validates :ch_eletiva_trab, presence: true, numericality: { only_integer: true }
  validates :ch_livre_aula, presence: true, numericality: { only_integer: true }
  validates :ch_livre_trab, presence: true, numericality: { only_integer: true }
  validates :ch_estagio, presence: true, numericality: { only_integer: true }
  validates :periodo, presence: true, length: {maximum: 20}
  
  
  def full_name
    "#{nome} - (#{periodo})"
  end
end
