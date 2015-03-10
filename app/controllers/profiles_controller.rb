class ProfilesController < ApplicationController
  def student
  	id = params[:id] # retrieve student ID from URI route
  	@student = Student.find(id)
  end

  def edit_student
    id = params[:id] # retrieve student ID from URI route
    @student = Student.find(id)
    @all_schools = College.all
    @all_majors = Major.all
  end

  def update_student
    student = Student.find(params[:id])
    student.update_attributes(:first_name => params[:first_name],
                              :last_name => params[:last_name],
                              :college_id => params[:college_id],
                              :major_id => params[:major_id],
                              :resume_link => params[:resume_link])
    if student.save
      flash[:notice] = "Profile Updated!"
      redirect_to(single_student_profile_path(student))
    else
      flash[:error] = "Profile failed to update!"
      redirect_to(edit_student_profile_path(student))
    end
  end

  def list_students
  	@all_students = Student.all
  end

  def staff
  end

  def company
  end

  def school
  end
end
