class Page < ActiveRecord::Base

	scope :menu_published, -> { where(status: 'PUBLIC').where.not(position: nil) }	
	scope :menu, -> { where(status: ['PUBLIC','DRAFT']).where.not(position: nil) }
	
	scope :nav, -> { where(status: ['PUBLIC','DRAFT'], parent_id: nil).where.not(position: nil).order("position ASC") }
	scope :nav_published, -> { where(parent_id: nil, status: 'PUBLIC').where.not(position: nil).order("position ASC") }

	scope :orphaned, -> { where(status: ['PUBLIC','DRAFT'], position: nil) }
	scope :orphaned_published, -> { where(position: nil, status: "PUBLIC") }
	
	belongs_to :user
	has_one :setting
	accepts_nested_attributes_for :setting#, :reject_if => lambda{|r| r[:value].blank?}

	has_many :rows, -> { order("position ASC") }

	acts_as_tree :order => "position"
	after_initialize :init

	validates_presence_of :label, :title, :permalink
	validates_uniqueness_of :permalink, scope: :user_id
	validates_format_of :permalink, :with => /[a-zA-Z_-]/, :if => Proc.new{|item| !item.permalink.blank?}, :message => "must include at least one letter"
	excluded_words = ['index','admin','catalog','resource','test','user','observation','entity','directory','search']
	validates_exclusion_of :permalink, :in => excluded_words, :message =>"Can't use reserved words: #{excluded_words.to_sentence}."	

	before_validation :fix_permalink

	ICON_SHORT = "fa-file-text-o fa-flip-horizontal"
	HOME_SHORT = "fa-home"
	ICON_EMPTY_SHORT = "fa-file-o"
	CLONE_SHORT = 'fa-files-o'
	UNDO_SHORT = "fa-undo"
	MENU_SHORT = "fa-chevron-circle-down"

	ICON = "fa fa-fw #{ICON_SHORT}"
	ICON_EMPTY = "fa fa-fw #{ICON_EMPTY_SHORT}"
	HOME = "fa fa-fw #{HOME_SHORT}"
	
	DRAFT = "fa fa-fw fa-exclamation-triangle wcms-warning"
	DELETE = "fa fa-fw fa-trash wcms-danger"
	MENU = "fa fa-fw fa-bars"
	SORT = "fa fa-fw fa-arrows"
	CLONE = "fa fa-fw #{CLONE_SHORT}"
	UNDO = "fa fa-fw #{UNDO_SHORT}"
	MENU = "fa fa-fw #{MENU_SHORT}"

	def icon
		if self.is_menu?(false)
			return Page::MENU
		elsif self.parent_id.nil? && self.position == 0
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

	def self.retrieve(page_id, user_id)
		if page_id.to_i.to_s == page_id #### integer, find by id
			self.where("id = ? AND user_id = ?", page_id, user_id).first
		else #### not numeric, find by permalink
			self.where("permalink = ? AND user_id = ?", page_id, user_id).first
		end
	end

	def is_menu?(published = false)
		if published == true
			self.children.menu_published.count > 0
		else
			self.children.menu.count > 0
		end
	end

	def status_icon
		case self.status
		when 'DRAFT'
			return Page::DRAFT
		when 'DELETE'
			return Page::DELETE
		end
	end

	def label_with_status
		return "#{self.label} <i class='#{self.status_icon}' title='#{self.status}'></i>"
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

	def duplicate
		new_page = self.dup
		new_page.permalink = self.generate_permalink
		new_page.status = 'DRAFT'
		new_page.label = "#{self.label} *duplicate*"
		new_page.position = nil
		new_page.save

		self.setting.duplicate(new_page.id)

		self.rows.each do |r|
			r.duplicate(new_page.id)
		end
	#	new_page.
	end

	def generate_permalink(old_p_link="")
		p_link = ""
		if !label.blank?
			p_link = label.parameterize
		end
		p_link.gsub!(/\W\./, "")
		p_link.gsub!(/\s/,"")
		p_link.gsub!(/["']/,"")
		p_link.gsub!(/\./,"-")
		p_link.downcase!
		
		p_link = Page.find_unique_permalink(self.user_id, p_link) unless p_link == old_p_link

		return p_link
	end

	def bootstrap
 		if self.rows.empty?
      r = self.rows.create 
      c = r.cells.create(:body => "")
    else
    	r = self.rows.first
    	c = r.cells.first
    end
    return r,c
	end

	private

	def fix_permalink
		if self.permalink.blank?
			self.permalink = self.generate_permalink
		end
	end

	def self.find_unique_permalink(user_id, p_link)
		i = 1
		
		new_permalink = nil
		new_permalink = String.new(p_link).downcase.dasherize
		
		until Page.where("user_id = ? AND permalink = ?", user_id, new_permalink).first.nil?
			new_permalink = nil
			new_permalink = String.new(p_link) << "-#{i.to_s}"
			i += 1
		end
		
		return new_permalink
	end	

	def init
		if self.new_record?
			self.build_setting(self.user.setting.attributes.slice("font_id", "font_weight", "fluid", "nav_location", "nav_color")) 
		elsif self.setting.nil?
			self.create_setting(self.user.setting.attributes.slice("font_id", "font_weight", "fluid", "nav_location", "nav_color")) 
		end
	end
	
end