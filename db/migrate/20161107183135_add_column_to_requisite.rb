class AddColumnToRequisite < ActiveRecord::Migration[5.0]
  def change
    add_column :requisites, :tipo, :integer
  end
end
