class Domain < ActiveRecord::Base
	belongs_to :user

	ICON_SHORT = "fa-globe"
	ICON = "fa fa-fw #{ICON_SHORT}"
	
end
