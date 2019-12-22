class User < ApplicationRecord
	validates :email, presence: true, uniqueness: true
	has_secure_password
	has_many :lessons
	has_many :cards

	def get_username()
		return email.split("@").first     
	end
end
