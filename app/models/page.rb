class Page < ActiveRecord::Base
	belongs_to :user
	has_one :setting
	accepts_nested_attributes_for :setting#, :reject_if => lambda{|r| r[:value].blank?}

	has_many :rows, -> { order("position ASC")}

	acts_as_tree :order => "position"
	after_initialize :init

	ICON_SHORT = "fa-file-text-o"
	HOME_SHORT = "fa-home"
	ICON_EMPTY_SHORT = "fa-file-o"
	CLONE_SHORT = 'fa-files-o'

	ICON = "fa fa-fw #{ICON_SHORT}"
	ICON_EMPTY = "fa fa-fw #{ICON_EMPTY_SHORT}"
	HOME = "fa fa-fw #{HOME_SHORT}"
	
	DRAFT = "fa fa-fw fa-exclamation-triangle"
	MENU = "fa fa-fw fa-bars"
	SORT = "fa fa-fw fa-arrows"
	CLONE = "fa fa-fw #{CLONE_SHORT}"

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

	private

	def init
		if self.setting.nil?
			self.create_setting(self.user.setting.attributes.slice("font_id", "font_weight", "fluid", "nav_location", "nav_color", "nav_weight")) 
		end
	end
	
end