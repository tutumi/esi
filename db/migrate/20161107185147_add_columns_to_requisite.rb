class AddColumnsToRequisite < ActiveRecord::Migration[5.0]
  def self.up
    add_column :requisites, :disciplina_id, :integer
    add_column :requisites, :requisito_id, :integer
  end
  def self.down
    remove_column :requisites, :disciplina_id, :integer
    remove_column :requisites, :requisito_id, :integer
  end
end
