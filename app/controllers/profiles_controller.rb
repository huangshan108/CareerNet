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
      @all_schools = College.all
      @all_majors = Major.all
      @all_skills = Skill.all
      @all_companies = Company.all
      @student_skills = @student.skills.all
    end
  end

  def edit_company
    if authorize([:company, :self])
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
    if authorize([:company, :self])
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
                                :resume_link => params[:resume_link],
                                :city => params[:city],
                                :state => params[:state],
                                :country => params[:country],
                                :company_id => params[:company_id],
                                :base_salary => params[:base_salary],
                                :years_experience => params[:years_experience],
                                :title => params[:title],
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
end
