class AccountsMailer < ActionMailer::Base
  default from: "careernet.devteam@gmail.com"
  def send_reset_password_email account
  	@username = account.name
  	@reset_password_link = account_start_reset_password_url(account.password_reset_token)
  	mail to: account.email, subject: "CareerNet Reset Password Request"
  end
end
