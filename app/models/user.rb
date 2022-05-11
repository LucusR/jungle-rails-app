class User < ActiveRecord::Base

  has_secure_password
  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, length: {minimum: 6 }
  validates :password_confirmation, presence: true

  def self.authenticate_with_credentials(email, password)
    @user = self.where("lower(email) = ?", email.delete(" ").downcase).first.try(:authenticate, password)
  end
end
