require 'date'
class ProfilesController < ApplicationController  
  before_action :confirm_logged_in

  def student
    if authorize([:staff, :company, :student, :self])
      id = params[:id]
      @id_1 = params[:id]
      @student = Student.find(id)
      @current_user = current_user
    end
  end

  def company
    if authorize([:all])
      id = params[:id]
      @company = Company.find(id)
    end
  end

  def staff
    if authorize([:all])
      id = params[:id]
      @staff = Staff.find(id)
    end
  end

  def students
    if authorize([:staff])
      redirect_to(list_students_path(1))
    end
    @all_companies = Company.select("id", "name")
  end

  def companies
    if authorize([:staff])
      redirect_to(list_companies_path(1))
    end
  end

  def edit_student
    if authorize([:staff, :student, :self])
      id = params[:id] # retrieve student ID from URI route
      @student = Student.find(id)
      @all_schools = College.select("id", "school_name")
      @all_majors = Major.select("id", "name")
      @all_skills = Skill.select("id", "name")
      @all_companies = Company.select("id", "name")
      @student_skills = @student.skills.all
    end
  end

  def edit_company
    if authorize([:staff, :company, :self])
      id = params[:id]
      @company = Company.find(id)
    end
  end

  def edit_staff
    if authorize([:staff, :self])
      id = params[:id]
      @staff = Staff.find(id)
    end
  end

  def update_company
    if authorize([:staff, :company, :self])
      company = Company.find(params[:id])
      company.update_attributes(:name => params[:name],
                                :city => params[:city],
                                :state => params[:state],
                                :country => params[:country],
                                :industry => params[:industry],
                                :website => params[:website])
      company.save
      flash[:notice] = "Profile Updated!"
      redirect_to(company_profile_path(company))
    end
  end

  def update_staff
    if authorize([:staff, :self])
      staff = Staff.find(params[:id])
      staff.update_attributes(:first_name => params[:first_name],
                              :last_name => params[:last_name],
                              :description => params[:description])
      staff.save
      flash[:notice] = "Profile Updated!"
      redirect_to(staff_profile_path(staff))
    end
  end

  def update_student
    if authorize([:student, :self])
      student = Student.find(params[:id])
      student.update_attributes(:first_name => params[:first_name],
                                :last_name => params[:last_name],
                                :college_id => params[:college_id],
                                :major_id => params[:major_id],
                                :graduation_date => params[:graduation_date],
                                :class_of => Date.parse(params[:graduation_date]).year,
                                :resume_link => params[:resume_link],
                                :notes => params[:notes])
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
  end

  def list_students
    if authorize([:staff])
      @all_students = Student.all
    end
  end

  def list_companies
    if authorize([:staff])
      @all_companies = Company.all
    end
  end

  def school
    if authorize([:all])
      id = params[:id] # retrieve student ID from URI route
      @college = College.find(id)
    end
  end

  def update_past_experience
  	student = Student.find(params[:id])
  	experience = {:company_id => params[:company_id],
                       :student_id => params[:id],
                       :city => params[:city],
                       :state => params[:state],
                       :country => params[:country],
                       :salary => params[:salary],
                       :job_title => params[:job_title]
                       }
    student.experiences.create(experience);
    student.save
    redirect_to(single_student_profile_path(student))
  end

  def delete_past_experience
  	student = Student.find(params[:id])
    student.experiences.destroy(params[:ex_id]);
    student.save
    redirect_to(single_student_profile_path(student))
  end
  
  
  def update_past_project
      student = Student.find(params[:id])
      past_project = {:project_name => params[:project_name],
          :student_id => params[:id],
          :position => params[:position],
          :description => params[:description],
          :start_date => params[:start_date],
          :end_date => params[:end_date]
      }
      student.projects.create(past_project);
      student.save
      redirect_to(single_student_profile_path(student))
  end
  
  def delete_past_project
      student = Student.find(params[:id])
      student.projects.destroy(params[:proj_id]);
      student.save
      redirect_to(single_student_profile_path(student))
  end
  
  
 def update_past_education
     student = Student.find(params[:id])
     past_education = {:school_name => params[:school_name],
         :student_id => params[:id],
         :major => params[:major],
         :start_date => params[:start_date],
         :graduation_date => params[:graduation_date]
     }
     student.educations.create(past_education);
     student.save
     redirect_to(single_student_profile_path(student))
 end
 
 def delete_past_education
     student = Student.find(params[:id])
     student.educations.destroy(params[:edu_id]);
     student.save
     redirect_to(single_student_profile_path(student))
 end

  


end
