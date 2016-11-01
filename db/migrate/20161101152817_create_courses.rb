class CreateCourses < ActiveRecord::Migration[5.0]
  def self.up
    create_table :courses do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :courses
  end
end