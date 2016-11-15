class AddColumnToCurriculum < ActiveRecord::Migration[5.0]
  def self.up
    add_column :curriculums, :tipo, :integer
  end
  def self.down
    remove_column :curriculums, :tipo, :integer
  end
end
