require 'date'
class ProfilesController < ApplicationController  
  before_action :confirm_logged_in

  def student
    if authorize([:staff, :company, :student, :self])
      @id_1 = params[:id]
      @student = Student.find(@id_1)
      @current_user = current_user
      @all_companies = Company.select("id", "name")
    end
  end

  def company
    if authorize([:all])
      @company = Company.find(params[:id])
    end
  end

  def staff
    if authorize([:all])
      @staff = Staff.find(params[:id])
    end
  end

  def students
    if authorize([:staff])
      redirect_to(list_students_path(1))
    end
  end

  def companies
    if authorize([:staff])
      redirect_to(list_companies_path(1))
    end
  end

  def edit_student
    if authorize([:staff, :student, :self])
      @student = Student.find(params[:id])
      @all_schools = College.select("id", "school_name")
      @all_majors = Major.select("id", "name")
      @all_skills = Skill.select("id", "name")
      @all_companies = Company.select("id", "name")
      @student_skills = @student.skills.all
    end
  end

  def edit_company
    if authorize([:staff, :company, :self])
      @company = Company.find(params[:id])
    end
  end

  def edit_staff
    if authorize([:staff, :self])
      @staff = Staff.find(params[:id])
    end
  end

  def update_company
    if authorize([:staff, :company, :self])
      company = Company.find(params[:id])
      premitted_attributes = [:name, :city, :state, :country, :industry, :website]
      company.update_attributes(create_new_attrs(premitted_attributes, params))
      flash[:notice] = "Profile Updated!"
      redirect_to(company_profile_path(company))
    end
  end

  def update_staff
    if authorize([:staff, :self])
      staff = Staff.find(params[:id])
      premitted_attributes = [:first_name, :last_name, :description]
      staff.update_attributes(create_new_attrs(premitted_attributes, params))
      flash[:notice] = "Profile Updated!"
      redirect_to(staff_profile_path(staff))
    end
  end

  def update_student
    if authorize([:student, :self])
      student = Student.find(params[:id])
      premitted_attributes = [:first_name, :last_name, :college_id, :major_id, :graduation_date, :class_of, :resume_link, :notes]
      student.update_attributes(create_new_attrs(premitted_attributes, params))
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
      @college = College.find(params[:id])
    end
  end

  def update_past_experience
  	student = Student.find(params[:id])
    premitted_attributes = [:company_id, :student_id, :city, :state, :country, :salary, :job_title]
    student.experiences.create(create_new_attrs(premitted_attributes, params))
    student.save
    redirect_to(single_student_profile_path(student))
  end

  def delete_past_experience
    delete_past("experience")
  end

  def delete_past_education
    delete_past("education")
  end
  
  def delete_past(field)
    student = Student.find(params[:id])
    case field
    when "experience"
      student.experiences.destroy(params[:ex_id])      
    when "education"
      student.educations.destroy(params[:edu_id])
    end
    student.save
    redirect_to(single_student_profile_path(student))
  end
  
  def update_past_project
    student = Student.find(params[:id])
    premitted_attributes = [:project_name, :student_id, :position, :description, :start_date, :end_date]
    student.projects.create(create_new_attrs(premitted_attributes, params))
    student.save
    redirect_to(single_student_profile_path(student))
  end
  
  def delete_past_project
    student = Student.find(params[:id])
    student.projects.destroy(params[:proj_id])
    student.save
    redirect_to(single_student_profile_path(student))
  end
  
  def update_past_education
   student = Student.find(params[:id])
   premitted_attributes = [:school_name, :student_id, :major, :start_date, :graduation_date]
   student.educations.create(create_new_attrs(premitted_attributes, params))
   student.save
   redirect_to(single_student_profile_path(student))
  end
end
