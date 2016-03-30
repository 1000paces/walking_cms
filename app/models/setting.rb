class Setting < ActiveRecord::Base
	belongs_to :user
	belongs_to :page
	belongs_to :font

	mount_uploader :image, ImageUploader

	attr_accessor :sync
	attr_accessor :color_str
	attr_accessor :crop_x, :crop_y, :crop_w, :crop_h, :placed_w, :placed_h

	ICON_SHORT = "fa-gears"
	ICON = "fa fa-fw #{ICON_SHORT}"

	DEFAULTS_ICON_SHORT = "fa-adjust"
	DEFAULTS_ICON = "fa fa-fw #{DEFAULTS_ICON_SHORT}"	

	NAV_LOCATION = {
		"Fixed to Top" => 0,
		"Below Header Image - Rounded" => 1,
		"Below Header Image - Square" => 2,
		"Fixed to Bottom" => 3,
		"Left Column" => 4,
		"Right Column" => 5,
		"Suppress Navigation" => 6
	}

	NAV_WEIGHT = {
		"Light" => 0,
		"Dark" => 1
	}

	def nav_color_converted
		return nav_color	
	end

	def nav_color_style
		if self.nav_color.nil?
			return ""
		else
			return "background-color: #{self.nav_color_converted};".html_safe
		end
	end

	def background_class
		if self.fluid?
			return "wcms-white-background"
		else
			return "wcms-grey-background"
		end
	end

	def container_type
		v = self.page.user.setting.framework
		if v == 'f6'
			return self.fluid? ? "row expanded" : "row"
		else
			return self.fluid? ? "container-fluid" : "container"
		end
	end

	def nav_weight_class
		nav_style = [4,5].include?(self.nav_location) ? 'nav' : 'navbar'
		#if self.nav_weight == 0 #### light
		if self.contrast == "light"
			return "#{nav_style}-light bg-faded"
		else #### dark
			return "#{nav_style}-dark bg-inverse"
		end
	end

	def nav_class(with_namespace=false)
		retval = with_namespace ? "wcms-" : ""
		case self.nav_location
		when 1 ##### below header image rounded
			return "navbar-rounded"
		when 2 #### below header image square
			retval << "navbar-full"
		when 3 #### fixed to bottom
			retval << "navbar-fixed-bottom"
		when 4
			return ""
		when 5 #### left or right nav
			return ""
		else #### fixed to top
			retval << "navbar-fixed-top"
		end
		return retval
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
		return rgb_to_hex(self.nav_color)
	end

	def duplicate(pageId)
		new_setting = self.dup
		new_setting.page_id = pageId
		if new_setting.save && !self.image.url.nil?
			img_path = Rails.root.join('public' + self.image.url)
			File.open(img_path) do |f|
				new_setting.image = f
			end
			new_setting.save!
		end
	end

	def text_color_style
		return "color: #{self.text_color};"
	end

	def title_background_style
		if self.title_background?
			return "background-color: #{self.title_background_color}; padding: 20px; border-radius: .25rem;"
		end
	end

	def overlap_style
		if self.overlap?
			if self.nav_location == 0
				return "wcms-overlap"
			else
				return "wcms-overlap"
			end
		end
	end

	def overlapped
		if self.overlap?
			return "wcms-overlapped-header"
		else
			return ""
		end
	end

	private

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