# == Schema Information
#
# Table name: accounts
#
#  id                     :integer          not null, primary key
#  name                   :string
#  email                  :string
#  account_type           :integer
#  created_at             :datetime
#  updated_at             :datetime
#  password_digest        :string
#  password_reset_token   :string
#  password_reset_sent_at :datetime
#


class Account < ActiveRecord::Base
    has_secure_password
    validates :email, presence: true, email: true
    validates_presence_of :password, :on => :create

    has_one :student
    has_one :staff
    has_one :company
    has_and_belongs_to_many :events

    def send_password_reset
      self.password_reset_sent_at = Time.zone.now
      self.password_reset_token = SecureRandom.urlsafe_base64
      self.update_attributes(:password_reset_sent_at => self.password_reset_sent_at, :password_reset_token => self.password_reset_token)
      AccountsMailer.send_reset_password_email(self).deliver_now
    end

    def getUser
        if self.account_type == 1
            return self.student
        elsif self.account_type == 2
            return self.staff
        elsif self.account_type == 3
            return self.company
        else
            return nil
        end
    end 

  def getInterviews(start_date, end_date)
    self.getUser.interviews.select{|i| 
      i.day >= start_date.to_date and i.day <= end_date.to_date
    }
  end

  def getEvents(start_date, end_date)
    self.getUser.account.events.select{ |e|
      e.time_start >= start_date.to_date and e.time_end <= end_date.to_date
    }
  end

  def getAppointments(start_date, end_date)
    self.getUser.appointments.select{|a| 
      a.day >= start_date.to_date and a.day <= end_date.to_date
    }
  end
    
end
