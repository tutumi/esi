class AddColumnsToCourse < ActiveRecord::Migration[5.0]
  def change
    add_column :courses, :nome, :string
    add_column :courses, :codcg, :integer
    add_column :courses, :codcur, :integer
    add_column :courses, :codhab, :integer
    add_column :courses, :duracao_min, :integer
    add_column :courses, :duracao_ideal, :integer
    add_column :courses, :duracao_max, :integer
    add_column :courses, :ch_obrigatoria_aula, :integer
    add_column :courses, :ch_obrigatoria_trab, :integer
    add_column :courses, :ch_eletiva_aula, :integer
    add_column :courses, :ch_eletiva_trab, :integer
    add_column :courses, :ch_livre_aula, :integer
    add_column :courses, :ch_livre_trab, :integer
    add_column :courses, :ch_estagio, :integer
  end
end
