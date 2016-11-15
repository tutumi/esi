class AddDetailsToCourses < ActiveRecord::Migration[5.0]
  def change
    add_column :courses, :id_course, :string
    add_column :courses, :name, :string
    add_column :courses, :is_mandatory, :boolean
    add_column :courses, :credits, :int
    add_column :courses, :ext_credits, :int
    add_column :courses, :hours, :int
  end
end
