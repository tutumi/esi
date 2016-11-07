class CreateCurriculums < ActiveRecord::Migration[5.0]
  def change
    create_table :curriculums do |t|
      t.references :course, foreign_key: true
      t.references :subject, foreign_key: true
      t.integer :semestre

      t.timestamps
    end
  end
end
