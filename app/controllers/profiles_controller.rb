class ProfilesController < ApplicationController
  def student
  	id = params[:id] # retrieve student ID from URI route
  	@student = Student.find(id)
  end

  def edit_student
    id = params[:id] # retrieve student ID from URI route
    @student = Student.find(id)
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
