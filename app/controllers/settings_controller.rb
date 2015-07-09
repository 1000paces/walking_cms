class SettingsController < ApplicationController
  before_action :set_user#, except: [:show]
  before_filter :require_user#, only: [:show]

	def index
		@setting = @user.setting
		if @setting.nil?
			@setting = @user.create_setting
		end
	end

	def update
		@setting = Setting.find(params[:id])
		@setting.update_attributes(setting_parameters)
		redirect_to user_path(@user)
	end

	private

	def setting_parameters
		params.require(:setting).permit(:font_id, :font_weight, :fluid, :top_nav)
	end

end