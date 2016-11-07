class AddUniqueIndexes < ActiveRecord::Migration[5.0]
  def change
    add_index :courses, [:codcg, :codcur, :codhab], unique: true
    add_index :subjects, :codigo, unique: true
  end
end
