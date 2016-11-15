class CreateSubjects < ActiveRecord::Migration[5.0]
  def self.up
    create_table :subjects do |t|
      t.string :codigo
      t.string :nome
      t.integer :credito_aula
      t.integer :credito_trab
      t.integer :carga_horaria
      t.integer :carga_estagio
      t.integer :carga_pratica
      t.integer :carga_aaca

      t.timestamps
    end
  end
  def self.down
    drop_table :subjects 
  end
end
