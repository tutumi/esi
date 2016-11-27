class RemoveCreditsFromCourse < ActiveRecord::Migration[5.0]
  def change
    remove_column :courses, :credits, :integer
  end
end
