class AddColumnToRequisite < ActiveRecord::Migration[5.0]
  def self.up
    add_column :requisites, :tipo, :integer
  end
  def self.down
    remove_column :requisites, :tipo, :integer
  end
end
