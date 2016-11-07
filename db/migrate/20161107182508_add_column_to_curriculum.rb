class AddColumnToCurriculum < ActiveRecord::Migration[5.0]
  def change
    add_column :curriculums, :tipo, :integer
  end
end
