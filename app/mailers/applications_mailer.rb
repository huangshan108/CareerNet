class ApplicationsMailer < ActionMailer::Base
  default from: "careernet.devteam@gmail.com"
  def application_confirmation_email_student application
  	@application = application
  	mail to: "careernet.student+#{application.student.id}@gmail.com", subject: "Application Confirmation"
  end

  def application_confirmation_email_company application
  	@application = application
  	mail to: "careernet.company+#{application.job.company.id}@gmail.com", subject: "You Received A New Application!"
  end
end
