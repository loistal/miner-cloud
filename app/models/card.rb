class Card < ApplicationRecord
	belongs_to :user
	validates :source, presence: true
	validates :stage, presence: true
	validates :timesreviewed, presence: true
	validates :timessuccess, presence: true
	validates :timesfailed, presence: true
end
