class UsersController < ApplicationController
	before_filter :signed_in_user, only: [:edit, :update, :index, :destroy]
	before_filter :correct_user,   only: [:edit, :update, :show]
	before_filter :admin_user,     only: [:destroy, :index, :make_admin, :revoke_admin]

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
		# Get the current @requested parameter from the users#index page.
		@req = params[:req]

		if @req == "std" # If the viewer wants to filter only standard (non-admin) users...
			# ...the @users collection is all non-admin users.
			@users = User.where(:admin => false).page(params[:page])

		elsif @req == "adm" # If the viewer wants to filter only admin users...
			# ...the @users collection is all admin users.
			@users = User.where(:admin => true).page(params[:page])

		else # Otherwise, the default @users collection is all users.
			@users = User.all.page(params[:page])
		end
	end

	def show
		@user = User.find(params[:id])
		@initiatives = @user.initiatives.page(params[:page])
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

	# Promote a user to an admin (admin-only power)
	def make_admin
		@user = User.find(params[:id])
		@user.update_attribute(:admin, true)

		redirect_to users_path
		flash[:success] = "Admin permissions set for '#{@user.name}'."
	end

	# Demote an admin to standard user (admin-only power)
	def revoke_admin
		@user = User.find(params[:id])

		if @user == current_user
			redirect_to users_path
			flash[:notice] = "You cannot revoke your own admin permissions."
		else
			@user.update_attribute(:admin, false)

			redirect_to users_path
			flash[:success] = "Admin permissions revoked for '#{@user.name}'."
		end
	end

	private
		# Rails 4 replacement for attr_accessible in User model
		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end

		# Define correct_user - ensure the user can only edit/update their own profiles
		def correct_user
			@user = User.find(params[:id])
			redirect_to(root_path) unless current_user?(@user) || current_user.admin?
		end

		def admin_user
			redirect_to(root_path) unless current_user.admin?
		end

end
