class UserSessionsController < ApplicationController
  #before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy

	def new
		@user = User.new
		@user_session = UserSession.new
	end

	def create
		Rails.logger.warn("\n\nUserSessionsController::create\n\n")
		@user_session = UserSession.new login_parameters#params.require(:user).permit(:login, :password)
		if @user_session.save
			Rails.logger.warn("#{@user_session.inspect}")
			Rails.logger.warn("#{session[:user_credentials_id]}")
			Rails.logger.warn("SHOULD BE A SESSION")
			flash[:notice] = "Login successful!"
			#redirect_to user_path(session[:user_credentials_id])
			redirect_to home_path#(session[:user_credentials_id])
		else
			Rails.logger.warn("NO SESSION")
			redirect_to new_user_session_path
		end
	end

	def destroy
		current_user_session.destroy
    flash[:notice] = "Logout successful!"
    redirect_back_or_default welcome_index_path
	end

	private

	def login_parameters
		params.require(:user).permit(:login, :password, :commit)
	end

end