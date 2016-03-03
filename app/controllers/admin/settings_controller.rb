class Admin::SettingsController < ApplicationController
  before_action :set_user#, except: [:show]
  before_filter :require_user#, only: [:show]

	def index
		#@setting = @user.setting
		#if @setting.nil?
	#		@setting = @user.create_setting
	#	end
	end

	def edit
		@setting = @user.setting
		if @setting.nil?
			@setting = @user.create_setting
		end
	end

	def update
		@setting = Setting.find(params[:id])
		@setting.update_attributes(setting_parameters)
		@sync = params[:sync]
		if !@sync.blank?
			@user.pages.each do |p|
				if p.setting.nil?
    			p.create_setting(@setting.attributes.slice("font_id", "font_weight", "fluid", "nav_location", "nav_color", "nav_weight"))
    		else
    			p.setting.update_attributes(setting_parameters)
    		end
			end
		end
		@page = Page.find session[:current_page]
		#redirect_to user_path(@user)
	end

	private

	def setting_parameters
		params.require(:setting).permit(:font_id, :font_weight, :fluid, :nav_location, :nav_color, :nav_weight)
	end

end