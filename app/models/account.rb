class Account < ActiveRecord::Base
	has_secure_password
	validates :email, presence: true, email: true
	validates_presence_of :password, :on => :create

	has_one :student
	has_one :company

	def send_password_reset
	  self.password_reset_sent_at = Time.zone.now
	  self.password_reset_token = SecureRandom.urlsafe_base64
	  self.update_attributes(:password_reset_sent_at => self.password_reset_sent_at, :password_reset_token => self.password_reset_token)
	  AccountsMailer.send_reset_password_email(self).deliver_now
	end
end
