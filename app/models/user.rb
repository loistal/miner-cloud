class User < ApplicationRecord
	validates :email, presence: true, uniqueness: true
	validates :source, presence: true
	has_secure_password
end
