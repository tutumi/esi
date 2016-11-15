class AddUniqueIndexes < ActiveRecord::Migration[5.0]
  def self.up
    add_index :courses, [:codcg, :codcur, :codhab], unique: true
    add_index :subjects, :codigo, unique: true
  end
  def self.down
    remove_index :courses, [:codcg, :codcur, :codhab], unique: true
    remove_index :subjects, :codigo, unique: true
  end
end
