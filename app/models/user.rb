class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :invitable

  after_create :send_notification_email

  def send_notification_email
    UserMailer.new_user_email(self).deliver_now
  end

  def valid_password?(pwd)
    begin
      super(pwd) # try the standard way
    rescue
      Pbkdf2PasswordHasher.check_password(pwd,self.encrypted_password) # if failed, then try the django's way
    end
  end
end
