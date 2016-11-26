class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  
  def add_curriculum
    
    parmList = params["data"]
    
    parmList.each do |t|
      entry = params["data"][t]
      subjects = Subject.where(codigo:"#{entry["course"]}")
      user = User.find(entry["user_id"])
      
      subjects.each do |s|
        
        cv = Curriculum.where(course_id: user.course_id,  subject_id: s.id)
        
        cv.each do |c|
          UserHasCurriculum.new(:user => user, :curriculum => c).save
        end
        
      end
      
    end
    
    
  end
  
end
