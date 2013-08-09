class UsersController < ApplicationController
	def new
		@user = User.new
	end

	def index
	end

	def show
		@user = User.find(params[:id])
	end

	private
		def app_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end

end
