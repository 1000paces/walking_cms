class Font < ActiveRecord::Base
	has_many :settings

	def link
		family_name = self.family.tr(" ", "+")
		retval = "<link href='http://fonts.googleapis.com/css?family=#{family_name}' rel='stylesheet' type='text/css'>"
	end

	def self.alpha
		Font.order("family ASC")
	end

	def self.alpha_collection
		Font.alpha.collect {|p| [ p.family, p.id ] }
	end
end