class Admin::SettingsController < Admin::AdminController

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
    			p.create_setting(@setting.attributes.slice("font_id", "font_weight", "fluid", "nav_location", "nav_color", "text_color", "framework", "overlap", "title_background", "title_background_color"))
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
		params.require(:setting).permit(:font_id, :font_weight, :fluid, :nav_location, :nav_color, :image, :shape, :text_color, :overlap, :title_background, :title_background_color, :framework)
	end

end