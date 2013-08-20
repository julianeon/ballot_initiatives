class UsersController < ApplicationController
	before_filter :signed_in_user, only: [:edit, :update, :index, :destroy]
	before_filter :correct_user,   only: [:edit, :update, :show]
	before_filter :admin_user,     only: [:destroy]

	def new
		if signed_in?
			redirect_to root_path
		else
			@user = User.new
		end
	end

	def create
		if signed_in?
			redirect_to root_path
		else
			@user = User.new(user_params)

			if @user.save
				sign_in @user
				flash[:success] = "Signup successful - welcome to SF Initiatives!"
				redirect_to @user
			else
				render 'new'
			end
		end
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])

		if @user.update_attributes(user_params)
			flash[:success] = "Profile updated"
			sign_in @user
			redirect_to @user
		else
			render 'edit'
		end
	end

	def index
		if current_user.admin?
			@users = User.all.page(params[:page])
		else
			redirect_to root_path
		end
	end

	def show
		@user = User.find(params[:id])
	end

	def destroy
		user_to_nuke = User.find(params[:id])
		
		if user_to_nuke == current_user
			flash[:notice] = "You cannot delete yourself."
			redirect_to users_path
		else
			user_to_nuke.destroy
			flash[:success] = "User destroyed."
			redirect_to users_path
		end
	end

	private
		# Rails 4 replacement for attr_accessible in User model
		def user_params
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

		def admin_user
			redirect_to(root_path) unless current_user.admin?
		end

end
