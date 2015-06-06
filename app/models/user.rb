class User < ActiveRecord::Base
	has_one :domain
	has_many :pages

	before_validation :copy_login_to_email

	acts_as_authentic do |c|
		c.crypto_provider = Authlogic::CryptoProviders::BCrypt
	end

	attr_accessor :linked_page_array
	attr_accessor :unlinked_page_array

	def friendly_name
		return "#{self.first_name} #{self.last_name}"
	end
	
	def linked_pages
		self.linked_page_array ||= self.pages.order("position ASC").select{|x| x.position!=nil}
	end

	def unlinked_pages
		self.unlinked_page_array ||= self.pages.select{|x| x.position==nil}
	end

	private

	def copy_login_to_email
		self.email = self.login
	end
end
