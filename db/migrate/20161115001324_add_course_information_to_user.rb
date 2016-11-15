class AddCourseInformationToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :startYear, :integer
    add_reference :users, :courses, foreign_key: true
  end
end
