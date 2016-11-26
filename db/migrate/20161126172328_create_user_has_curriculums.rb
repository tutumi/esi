class CreateUserHasCurriculums < ActiveRecord::Migration[5.0]
  def change
    create_table :user_has_curriculums do |t|
      t.references :user, foreign_key: true
      t.references :curriculum, foreign_key: true

      t.timestamps
    end
  end
end
