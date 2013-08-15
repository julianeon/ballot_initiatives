class UsersController < ApplicationController
	def new
		@user = User.new
	end

	def create
		@user = User.new(params[:user])

		if @user.save
			sign_in @user
			flash[:success] = "Signup successful - welcome to SF Initiatives!"
			redirect_to @user
		else
			render 'new'
		end
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])

		if @user.update_attributes(params[:user])
			flash[:success] = "Profile updated"
			sign_in @user
			redirect_to @user
		else
			render 'edit'
		end
	end

	def index
	end

	def show
		@user = User.find(params[:id])
	end

	private
		# Rails 4 replacement for attr_accessible in User model
		def app_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end

end
