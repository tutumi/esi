class AddCourseInformationToUser < ActiveRecord::Migration[5.0]
  def self.up
    add_column :users, :startYear, :integer
    add_reference :users, :courses, foreign_key: true
  end
  def self.down
    remove_column :users, :startYear, :integer
    remove_reference :users, :courses, foreign_key: true
  end
end
