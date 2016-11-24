class CreateJoinTableUserCurriculum < ActiveRecord::Migration[5.0]
  def change
    create_join_table :users, :curriculums do |t|
      # t.index [:user_id, :curriculum_id]
      # t.index [:curriculum_id, :user_id]
    end
  end
end
