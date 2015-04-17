class ProfilesController < ApplicationController
    
  
  
  before_action :confirm_logged_in
  before_action :profile_restriction, only:[:edit_student,:update_student,:student]
  def student
    id = params[:id]
    @student = Student.find(id)
  end

  def students
    redirect_to(list_students_path(1))
  end

  def edit_student
    id = params[:id] # retrieve student ID from URI route
    @student = Student.find(id)
    @all_schools = College.all
    @all_majors = Major.all
    @all_skills = Skill.all
    @student_skills = @student.skills.all
    
  end

  def update_student
    student = Student.find(params[:id])
    student.update_attributes(:first_name => params[:first_name],
                              :last_name => params[:last_name],
                              :college_id => params[:college_id],
                              :major_id => params[:major_id],
                              :graduation_date => params[:graduation_date],
                              :resume_link => params[:resume_link])
    skill_id_list = student.skill_ids

    if not params[:add_skill_name].empty?
      if Skill.where(:name => params[:add_skill_name]).empty?
        skill = {}
        skill[:name] = params[:add_skill_name]
        s = Skill.create(skill)
        s.update_attributes(:id => s.id)
        skill_id_list << s.id.to_i
        student.skill_ids = skill_id_list
      else
        if not skill_id_list.include? Skill.where(:name => params[:add_skill_name]).first.id
          skill_id_list << Skill.where(:name => params[:add_skill_name]).first.id
          student.skill_ids = skill_id_list
        end
      end
    end
    if not params[:remove_skill_name].empty?
      if not Skill.where(:name => params[:remove_skill_name]).empty?
        s_id = student.skills.where(:name => params[:remove_skill_name]).first.id
        skill_id_list.delete(s_id.to_i)
        student.skill_ids = skill_id_list
      end
    end      
    student.save
    flash[:notice] = "Profile Updated!"
    redirect_to(single_student_profile_path(student))
  end

  def list_students
  	@all_students = Student.all
  end

  def staff
  end

  def company
  end

  def school
    id = params[:id] # retrieve student ID from URI route
    @college = College.find(id)
  end
end
