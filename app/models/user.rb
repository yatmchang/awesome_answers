class User < ActiveRecord::Base
  #has_Secure_password will give us functionalities needed for user authenticaltion; 1- it will add attribute accessors: password, password_confirmation. 2 - it will add a validation for password presence and length of password (4..72). 3- if password confirmation is set, it will validate it's the same as password. 4- it will add handy methods for us to automatically hash the passwordto the password_digest field and compare a given password.
  has_secure_password
  has_many :questions, dependent: :nullify

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true,
                    uniqueness: true,
                    format: /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  def full_name
    "#{first_name} #{last_name}"
  end
end
