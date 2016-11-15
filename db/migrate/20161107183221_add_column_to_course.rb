class AddColumnToCourse < ActiveRecord::Migration[5.0]
  def self.up
    add_column :courses, :periodo, :integer
  end
  def self.remove
    remove_column :courses, :periodo, :integer
  end
end
