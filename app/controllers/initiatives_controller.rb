class InitiativesController < ApplicationController
	before_action :set_initiative, only: [:show, :edit, :update, :destroy]
	before_filter :signed_in_user, only: [:new, :create, :update]
	before_filter :correct_user,   only: [:edit, :update, :destroy]

	# GET /initiatives
	# GET /initiatives.json
	def index
		@initiatives = Initiative.all.page(params[:page])
	end

	# GET /initiatives/1
	# GET /initiatives/1.json
	def show
	end

	# GET /initiatives/new
	def new
		@initiative = Initiative.new
	end
	
	# POST /initiatives
	# POST /initiatives.json
	def create
		@initiative = current_user.initiatives.build(initiative_params)

		# Set @initiative.last_edited_by to be the id of the currently signed-in user upon creation
		last_editing_user

		respond_to do |format|
			if @initiative.save
				format.html { redirect_to @initiative, notice: 'Initiative was successfully created.' }
				format.json { render action: 'show', status: :created, location: @initiative }
			else
				format.html { render action: 'new' }
				format.json { render json: @initiative.errors, status: :unprocessable_entity }
			end
		end
	end

	# GET /initiatives/1/edit
	def edit
	end

	# PATCH/PUT /initiatives/1
	# PATCH/PUT /initiatives/1.json
	def update
		# Set @initiative.last_edited_by to be the id of the currently signed-in user upon creation
		last_editing_user

		respond_to do |format|
			if @initiative.update(initiative_params)
				format.html { redirect_to @initiative, notice: 'Initiative was successfully updated.' }
				format.json { head :no_content }
			else
				format.html { render action: 'edit' }
				format.json { render json: @initiative.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /initiatives/1
	# DELETE /initiatives/1.json
	def destroy
		@initiative.destroy
		respond_to do |format|
			format.html { redirect_to initiatives_url }
			format.json { head :no_content }
		end
	end

	private
		# Use callbacks to share common setup or constraints between actions.
		def set_initiative
			@initiative = Initiative.find(params[:id])
		end

		def last_editing_user
			@initiative.last_edited_by = current_user.id
		end

		def correct_user
			redirect_to root_path unless (current_user.admin? || current_user == @initiative.user)
		end

		# Never trust parameters from the scary internet, only allow the white list through.
		def initiative_params
			params.require(:initiative).permit(:election_date, :prop_letter, :title, :description, :pass_fail, :yes_count, :no_count, :percent_required, :measure_type, :initiator, :scan_url, :user_id, :last_edited_by)
		end
end
