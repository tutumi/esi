class AddColumnToCourse < ActiveRecord::Migration[5.0]
  def change
    add_column :courses, :periodo, :integer
  end
end
