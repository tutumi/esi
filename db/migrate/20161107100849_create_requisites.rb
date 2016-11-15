class CreateRequisites < ActiveRecord::Migration[5.0]
  def self.up
    create_table :requisites do |t|
      t.belongs_to :course, foreign_key: true

      t.timestamps
    end
  end
  def self.down
    drop_table :requisites
  end
end
