class User < ApplicationRecord

  has_secure_password

  has_many :reviews, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 8, maximum: 20 }

  def self.authenticate_with_credentials(email, password)
    # Return the user if the user exists AND the password entered is correct
    user = self.where("email ILIKE ?", email.strip).first
    user && user.authenticate(password) ? user : nil
  end
end
