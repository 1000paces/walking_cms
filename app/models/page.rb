class Page < ActiveRecord::Base
	belongs_to :user

	acts_as_tree :order => "position"

	ICON = "fa fa-fw fa-file-o"
	HOME = "fa fa-fw fa-home"
	DRAFT = "fa fa-fw fa-exclamation-triangle"

	def icon
		if self.parent_id.nil? && self.position == 0
			return Page::HOME
		else
			return Page::ICON
		end
	end

	def status_icon
		if self.status != 'PUBLIC'
			return Page::DRAFT
		end
	end
end