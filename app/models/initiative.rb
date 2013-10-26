class Initiative < ActiveRecord::Base
	# Association(s)
	belongs_to :user

	# Validations
	validates :user_id, presence: true, on: :create
end
