class Page < ActiveRecord::Base
	belongs_to :user
	has_one :setting
	accepts_nested_attributes_for :setting#, :reject_if => lambda{|r| r[:value].blank?}

	has_many :rows, -> { order("position ASC")}

	acts_as_tree :order => "position"
	after_initialize :init

	validates_presence_of :label, :title, :permalink
	validates_uniqueness_of :permalink, scope: :user_id
	validates_format_of :permalink, :with => /[a-zA-Z_-]/, :if => Proc.new{|item| !item.permalink.blank?}, :message => "must include at least one letter"
	excluded_words = ['index','admin','catalog','resource','test','user','observation','entity','directory','search']
	validates_exclusion_of :permalink, :in => excluded_words, :message =>"Can't use reserved words: #{excluded_words.to_sentence}."	

	ICON_SHORT = "fa-file-text-o"
	HOME_SHORT = "fa-home"
	ICON_EMPTY_SHORT = "fa-file-o"
	CLONE_SHORT = 'fa-files-o'
	UNDO_SHORT = "fa-undo"

	ICON = "fa fa-fw #{ICON_SHORT}"
	ICON_EMPTY = "fa fa-fw #{ICON_EMPTY_SHORT}"
	HOME = "fa fa-fw #{HOME_SHORT}"
	
	DRAFT = "fa fa-fw fa-exclamation-triangle"
	MENU = "fa fa-fw fa-bars"
	SORT = "fa fa-fw fa-arrows"
	CLONE = "fa fa-fw #{CLONE_SHORT}"
	UNDO = "fa fa-fw #{UNDO_SHORT}"

	def icon
		if self.parent_id.nil? && self.position == 0
			return Page::HOME
		else
			return Page::ICON
		end
	end

	def permalink_or_id
		if self.permalink.blank?
			return self.id
		else
			return self.permalink
		end
	end

	def status_icon
		if self.status != 'PUBLIC'
			return Page::DRAFT
		end
	end

	def font
		if self.setting && self.setting.font
			return self.setting.font
		else
			return nil
		end
	end

	def font_weight
		if self.setting && self.setting.font_weight
			case self.setting.font_weight
			when 100
				return self.font.min_weight
			when 700
				return self.font.max_weight
			else
				return self.font.normal_weight
			end
		else
			return ''
		end
	end	

	private

	def init
		if self.new_record?
			self.build_setting(self.user.setting.attributes.slice("font_id", "font_weight", "fluid", "nav_location", "nav_color", "nav_weight")) 
		elsif self.setting.nil?
			self.create_setting(self.user.setting.attributes.slice("font_id", "font_weight", "fluid", "nav_location", "nav_color", "nav_weight")) 
		end
	end
	
end