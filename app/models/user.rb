class User < ApplicationRecord
	has_secure_password
	before_create { generate_token(:auth_token) }
	attr_accessor :remember_me

	enum role: { user: 0, admin: 1 }

	validates :email, uniqueness: true, presence: true


	has_many :books, dependent: :destroy

  	def generate_token(column)
  		begin
  			self[column] = SecureRandom.urlsafe_base64
  		end while User.exists?(column => self[column])
  	end
end
