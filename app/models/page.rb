class Page < ActiveRecord::Base
	belongs_to :user
	has_one :setting
	accepts_nested_attributes_for :setting#, :reject_if => lambda{|r| r[:value].blank?}

	has_many :rows, -> { order("position ASC")}

	acts_as_tree :order => "position"
	after_initialize :init

	ICON_SHORT = "fa-file-text-o"
	HOME_SHORT = "fa-home"
	ICON = "fa fa-fw fa-file-text-o"
	HOME = "fa fa-fw fa-home"
	DRAFT = "fa fa-fw fa-exclamation-triangle"
	MENU = "fa fa-fw fa-bars"

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