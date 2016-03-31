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
		"Header Top - Rounded" => 1,
		"Header Top - Square" => 2,		
		"Header Bottom - Rounded" => 3,
		"Header Bottom - Square" => 4,
		"Fixed to Bottom" => 5,
		"Left Column" => 6,
		"Right Column" => 7,
		"Suppress Navigation" => 8
	}

	NAV_WEIGHT = {
		"Light" => 0,
		"Dark" => 1
	}

	BODY_CLASSES = "wcms-above wcms-below wcms-navbar-suppressed wcms-white-background wcms-grey-background wcms-navbar-full wcms-navbar-rounded wcms-navbar-fixed-bottom wcms-navbar-fixed-top wcms-overlap"

	def nav_class(with_namespace=false)
		retval = with_namespace ? "wcms-" : ""
		case self.nav_location
		when 1 #### top of page, scrolls away, rounded
			retval << "navbar-rounded"
			retval << " wcms-above"# unless with_namespace
		when 2 #### top of page, scrolls away, squared
			retval << "navbar-full"
			retval << " wcms-above"# unless with_namespace
		when 3 ##### below header image rounded  (was 1)
			retval << "navbar-rounded"
			retval << " wcms-below"# unless with_namespace
		when 4 #### below header image square (was 2)
			retval << "navbar-full"
			retval << " wcms-below"# unless with_namespace
		when 5 #### fixed to bottom, doesn't scroll away (was 3)
			retval << "navbar-fixed-bottom"
		when 6, 7 #### left or right nav (was 4,5)
			return ""
		when 8 #### Suppressed nav (was 6)
			retval << "navbar-suppressed"
		else #### fixed to top, doesn't scroll away
			retval << "navbar-fixed-top"
		end
		return retval
	end

	def nav_loc
		retval = ""
		case self.nav_location
		when 1 #### top of page, scrolls away, rounded
			retval << "above-header-rounded"
		when 2 #### top of page, scrolls away, squared
			retval << "above-header-squared"
		when 3 ##### below header image rounded  (was 1)
			retval << "below-header-rounded"
		when 4 #### below header image square (was 2)
			retval << "below-header-squared"
		when 5 #### fixed to bottom, doesn't scroll away (was 3)
			retval << "fixed-to-bottom"
		when 6
			retval << "left-side"
		when 7 #### left or right nav (was 4,5)
			retval << "right-side"
		when 8 #### Suppressed nav (was 6)
			retval << "suppressed"
		else #### fixed to top, doesn't scroll away
			retval << "fixed-to-top"
		end
		retval <<  "-overlap" if self.overlap?
		return retval
	end

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
		#v = self.page.user.setting.framework
		v = self.framework
		if v == 'f6'
			return self.fluid? ? "row expanded" : "row"
		else
			return self.fluid? ? "container-fluid" : "container"
		end
	end

	def nav_weight_class
		nav_style = [6,7].include?(self.nav_location) ? 'nav' : 'navbar'
		if self.contrast == "light"
			return "#{nav_style}-light bg-faded"
		else #### dark
			return "#{nav_style}-dark bg-inverse"
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