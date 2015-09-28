class UsersController < ApplicationController
	before_action: :logged_in?, only: [:show, :index]
	def index
		@users = User.all
	end

	def new
		@user = User.new
	end

	def create
		@user = User.create(user_params)
		if @user != nil
			redirect_to "/users/#{@user.id}"
		else
			redirect_to sign_in_path
		end
	end

	def show
		@user = User.find(params[:id])
		if current_user == @user
			render :show
		else
			redirect_to sign_in_path
		end
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		user_id = params[:id]
		user = User.find(user_id)

		update_attributes = params.require(:user).permit(:first_name, :last_name)
		user.update_attributes(update_attributes)

		redirect_to "/users/#{@user.id}"
	end

	private

	def user_params
		params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
	end

end
