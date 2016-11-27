class RemoveColumnsFromCourse < ActiveRecord::Migration[5.0]
  def change
    remove_column :courses, :id_course, :integer
    remove_column :courses, :name, :string
    remove_column :courses, :is_mandatory, :boolean
    remove_column :courses, :ext_credits, :integer
    remove_column :courses, :hours, :integer
  end
end
