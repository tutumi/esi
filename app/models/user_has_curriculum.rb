class UserHasCurriculum < ApplicationRecord
  belongs_to :user
  belongs_to :curriculum
end
