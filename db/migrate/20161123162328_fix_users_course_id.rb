class FixUsersCourseId < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :courses_id, :course_id
  end
end
