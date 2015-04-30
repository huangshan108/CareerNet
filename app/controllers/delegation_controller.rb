class DelegationController < ApplicationController
	def sign_in_as(account_id)
		if !is_staff?
			flash[:error] = 'Unauthorized action.'
		else
			session[:signed_in_as] = account_id
		end
		redirect_to dashboard_path
	end

	def switch_back
		if !delegation_on?
			flash[:error] = 'You are already on your own account.'
		else
			session[:signed_in_as] = nil
			flash[:notice] = 'Successfully switched back to your own account.'
		end
		redirect_to dashboard_path
	end

	def as_student
		if Student.exists? params[:id]
			sign_in_as(Student.find(params[:id]).account_id)
		else
			flash[:error] = 'Student does not exist'
			redirect_to dashboard_path
		end
	end

	def as_company
		if Company.exists? params[:id]
			sign_in_as(Company.find(params[:id]).account_id)
		else
			flash[:error] = 'Company does not exist'
			redirect_to dashboard_path
		end
	end
end
