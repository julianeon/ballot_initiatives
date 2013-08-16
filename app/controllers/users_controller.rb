class UsersController < ApplicationController
	before_filter :signed_in_user, only: [:edit, :update, :index]
	before_filter :correct_user,   only: [:edit, :update]

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
		@users = User.all
	end

	def show
		@user = User.find(params[:id])
	end

	private
		# Rails 4 replacement for attr_accessible in User model
		def app_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end

		# Define signed_in_user - for actions only accessible to signed-in users
		def signed_in_user
			unless signed_in?
				store_location
				redirect_to signin_path, notice: "Please sign in."
			end
		end

		# Define correct_user - ensure the user can only edit/update their own profiles
		def correct_user
			@user = User.find(params[:id])
			redirect_to(root_path) unless current_user?(@user)
		end

end
