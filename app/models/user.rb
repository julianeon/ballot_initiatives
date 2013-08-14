class User < ActiveRecord::Base
	DeviseController.class_eval do
		def resource_params
			unless params[resource_name].blank?
				params.require(resource_name).permit(:name, :email)
			end
		end
	end
	
	has_secure_password

	# Callbacks
	before_save { self.email.downcase! }

	# Validations
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates :name, presence: true, length: { maximum: 50 }
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
										uniqueness: { case_sensitive: false }
	validates :password, presence: true, length: { minimum: 6 }
	validates :password_confirmation, presence: true
end
