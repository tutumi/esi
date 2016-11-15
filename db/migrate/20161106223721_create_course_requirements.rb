class CreateCourseRequirements < ActiveRecord::Migration[5.0]
  def change
    create_table :course_requirements do |t|
      t.string :course_id
      t.string :course_requirement
      t.integer :is_strong

      t.timestamps
    end
  end
end
