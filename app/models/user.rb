class User < ActiveRecord::Base
	has_one :domain
	has_one :setting
	has_many :pages

	before_validation :copy_login_to_email
	after_find :bootstrap

	acts_as_authentic do |c|
		c.crypto_provider = Authlogic::CryptoProviders::BCrypt
	end

	attr_accessor :linked_page_array
	attr_accessor :unlinked_page_array

	ICON = "fa fa-fw fa-user"

	def friendly_name
		return "#{self.first_name} #{self.last_name}"
	end
	
	def nav_pages
		self.linked_page_array ||= self.pages.order("position ASC").select{|x| x.position!=nil}
	end

	def top_nav_pages
		self.linked_page_array ||= self.pages.where("parent_id IS NULL").order("position ASC").select{|x| x.position!=nil}
	end

	def non_nav_pages
		self.unlinked_page_array ||= self.pages.select{|x| x.position==nil}
	end

	def home_page
		if self.top_nav_pages.blank?
			self.linked_page_array = nil
			return self.pages.create(label: "My New Page", position: 0)
		else
			return self.top_nav_pages.first
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

	def copy_login_to_email
		self.email = self.login
	end

	def bootstrap
		s = self.create_setting if self.setting.nil?
	end
end
