class Font < ActiveRecord::Base
	has_many :settings

	def link(w='')
		family_name = self.family.tr(" ", "+")
		if w==''
			retval = "<link href='http://fonts.googleapis.com/css?family=#{family_name}' rel='stylesheet' type='text/css'>"
		else
			retval = "<link href='http://fonts.googleapis.com/css?family=#{family_name}:#{w}' rel='stylesheet' type='text/css'>"
		end
		return retval
	end

	def self.alpha
		Font.order("family ASC")
	end

	def self.alpha_collection
		Font.alpha.collect { |p| [ p.family, p.id ] }.prepend(['Helvetica',0])
	end
end