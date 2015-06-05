class User < ActiveRecord::Base
	has_one :domain

	before_validation :copy_login_to_email

	acts_as_authentic do |c|
		c.crypto_provider = Authlogic::CryptoProviders::BCrypt
	end

	def friendly_name
		return "#{self.first_name} #{self.last_name}"
	end

	private

	def copy_login_to_email
		self.email = self.login
	end
end
