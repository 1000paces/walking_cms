class Cell < ActiveRecord::Base
	include ActionView::Helpers::SanitizeHelper

	#attr_accessible :image, :remote_image_url
	belongs_to :row
	mount_uploader :image, ImageUploader

	after_find :fix_the_width

	attr_accessor :color_str

	ICON_SHORT = "fa-th-large"
	TEXT_ICON_SHORT = "fa-align-left"
	IMAGE_ICON_SHORT = "fa-image"
	CODE_ICON_SHORT = "fa-code"
	SETTINGS_ICON_SHORT = "fa-cogs"
	SAVE_ICON_SHORT = "fa-save"
	CANCEL_ICON_SHORT = "fa-times"

	ICON = "fa fa-fw #{ICON_SHORT}"
	TEXT_ICON = "fa fa-fw #{TEXT_ICON_SHORT}"
	IMAGE_ICON = "fa fa-fw #{IMAGE_ICON_SHORT}"
	CODE_ICON = "fa fa-fw #{CODE_ICON_SHORT}"
	SETTINGS_ICON = "fa fa-fw #{SETTINGS_ICON_SHORT}"
	SAVE_ICON = "fa fa-fw #{SAVE_ICON_SHORT}"
	CANCEL_ICON = "fa fa-fw #{CANCEL_ICON_SHORT}"
	
	BREAKPOINTS = {
		"Extra Small Devices (<544px)" => "xs",
		"Small Devices (≥544px)" => "sm",
		"Medium Devices (≥768px)" => "md",
		"Large Devices (≥992px)" => "lg",
		"Extra Large Devices (≥1200px)" => "xl"
	}

	WIDTH = {
		"Width 1 (1/12)" => 1,
		"Width 2 (1/6)" => 2,
		"Width 3 (Quarter Width)" => 3,
		"Width 4 (One Third Width)" => 4,
		"Width 5 (5/12)" => 5,
		"Width 6 (Half Width)" => 6,
		"Width 7 (7/12)" => 7,
		"Width 8 (2/3)" => 8,
		"Width 9 (Three Quarters)" => 9,
		"Width 10 (5/6)" => 10,
		"Width 11 (11/12)" => 11,
		"Width 12 (Full Width)" => 12,
	}

	OFFSET = {
		"No Offset" => 0,
		"Offset 1 (1/12)" => 1,
		"Offset 2 (1/6)" => 2,
		"Offset 3 (Quarter Width)" => 3,
		"Offset 4 (One Third Width)" => 4,
		"Offset 5 (5/12)" => 5,
		"Offset 6 (Half Width)" => 6,
		"Offset 7 (7/12)" => 7,
		"Offset 8 (2/3)" => 8,
		"Offset 9 (Three Quarters)" => 9,
		"Offset 10 (5/6)" => 10,
		"Offset 11 (11/12)" => 11,		
	}

	VARIANTS = {
		'Default (No Border)' => 0,
		'Border, White Background' => 1,
		'Primary' => 2,
		'Success' => 3,
		'Info' => 4,
		'Warning' => 5,
		'Danger' => 6,
		'Inverse' => 7,
		'Custom' => 8
	}

	def division
		case self.width
		when 12
			return [6,6]
		when 11
			return [5,6]
		when 10
			return [5,5]
		when 9
			return [4,5]
		when 8
			return [4,4]
		when 7
			return [3,4]
		when 6
			return [3,3]
		when 5
			return [2,3]
		when 4
			return [2,2]
		when 3
			return [1,2]
		when 2
			return [1,2]
		when 1
			return [1,1]
		else
			return [6,6]
		end
	end

	def empty?
		if strip_tags(self.body).blank? && self.image.blank? && self.embed_code.blank? && self.headline.blank?
			return true
		else
			return false
		end
	end

	def full?
		if !strip_tags(self.body).blank? && !self.image.blank? && !self.embed_code.blank? && !self.headline.blank?
			return true
		else
			return false
		end
	end

	def gauge
		if self.empty?
			return 'empty'
		elsif self.full?
			return 'full'

		elsif !strip_tags(self.body).blank? && self.image.blank? && self.embed_code.blank? && self.headline.blank?
			return 'body'
		elsif strip_tags(self.body).blank? && !self.image.blank? && self.embed_code.blank? && self.headline.blank?
			return 'image'
		elsif strip_tags(self.body).blank? && self.image.blank? && !self.embed_code.blank? && self.headline.blank?
			return 'code'
		elsif strip_tags(self.body).blank? && self.image.blank? && self.embed_code.blank? && !self.headline.blank?
			return 'headline'

		elsif !strip_tags(self.body).blank? && !self.image.blank? && self.embed_code.blank? && self.headline.blank?
			return 'body_image'
		elsif !strip_tags(self.body).blank? && self.image.blank? && !self.embed_code.blank? && self.headline.blank?
			return 'body_code'
		elsif !strip_tags(self.body).blank? && self.image.blank? && self.embed_code.blank? && !self.headline.blank?
			return 'body_headline'
		elsif strip_tags(self.body).blank? && !self.image.blank? && self.embed_code.blank? && !self.headline.blank?
			return 'image_headline'
		elsif strip_tags(self.body).blank? && !self.image.blank? && !self.embed_code.blank? && self.headline.blank?
			return 'image_code'
		elsif strip_tags(self.body).blank? && self.image.blank? && !self.embed_code.blank? && !self.headline.blank?
			return 'code_headline'
		
		elsif !strip_tags(self.body).blank? && !self.image.blank? && self.embed_code.blank? && !self.headline.blank?
			return 'body_image_headline'
		elsif !strip_tags(self.body).blank? && !self.image.blank? && !self.embed_code.blank? && self.headline.blank?
			return 'body_image_code'
		elsif strip_tags(self.body).blank? && !self.image.blank? && !self.embed_code.blank? && !self.headline.blank?
			return 'image_code_headline'
		elsif !strip_tags(self.body).blank? && self.image.blank? && !self.embed_code.blank? && !self.headline.blank?
			return 'body_code_headline'
		else
			return 'error'
		end

	end

	def variant_class
		case self.variant
		when 1,8
			'card'
		when 2
			'card card-primary card-inverse'
		when 3
			'card card-success card-inverse'
		when 4
			'card card-info card-inverse'
		when 5
			'card card-warning card-inverse'
		when 6
			'card card-danger card-inverse'
		when 7
			'card card-secondary card-inverse'
		else
			'wcms-no-card'
		end
	end

	def has_uri?
		return false if self.embed_code.blank?
		begin
	  	uri = URI.parse(self.embed_code)
	  	%w( http https ).include?(uri.scheme)
		rescue URI::BadURIError
		  false
		rescue URI::InvalidURIError
		  false
		end
	end

	def background_color_converted
		return background_color
	end

	def background_color_style
		if self.background_color.nil? || self.variant < 8
			return ""
		else
			return "background-color: #{self.background_color_converted};".html_safe
		end
	end

	def background_contrast_class
		#nav_style = [4,5].include?(self.nav_location) ? 'nav' : 'navbar'
		#if self.nav_weight == 0 #### light
		if self.contrast == "light"
			return ""
		else #### dark
			return "card-inverse"
		end
	end

	def contrast
		color = self.hex_version
	  # Break hex into 3-item array, convert hex to decimal
	  rgb_ary = color.gsub(/\#/, "").scan(/../).collect(&:hex)

	  # Average rgb values
	  rgb_avg = rgb_ary.reduce(:+).div(rgb_ary.size)

	  # Determine contrast color by cutoff
	  contrasting_color = rgb_avg > 127  ? "light" : "dark"

	  return contrasting_color
	end

	def hex_version
		return rgb_to_hex(self.background_color)
	end	

	private

	def fix_the_width
		if self.width > 12
			self.width = 12
		elsif width < 1
			self.width = 1
		end
	end


	def rgb_to_hex(value, drop_opacity=true)
	  c = %Q{
	    #{
	      value.match(/[\d,\s]+/)[0].split(',').map(&:strip).map { |value|
	        value.to_i.to_s(16).rjust(2, '0')
	      }.join('')
	    }
	  }.strip
	  if drop_opacity == true
	  	return c[0,6]
	  else
	  	return c
	  end
	end	
end