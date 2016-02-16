module UsersHelper

	def background_class(setting)
		if setting.nil? || setting.fluid?
			return "wcms-white-background"
		else
			return "wcms-grey-background"
		end
	end

end
