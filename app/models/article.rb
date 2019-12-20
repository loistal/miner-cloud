class Article < ApplicationRecord
	belongs_to :user
	validates :title, presence: true
	validates :difficulty, presence: true
	validates :lanugage, presence: true
	validates :lesson, presence: true, length: { minimum: 100, maximum: 2000 }
end
