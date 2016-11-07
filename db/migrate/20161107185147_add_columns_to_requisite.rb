class AddColumnsToRequisite < ActiveRecord::Migration[5.0]
  def change
    add_column :requisites, :disciplina_id, :integer
    add_column :requisites, :requisito_id, :integer
  end
end
