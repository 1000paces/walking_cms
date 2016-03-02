class Setting < ActiveRecord::Base
	belongs_to :user
	belongs_to :page
	belongs_to :font

	attr_accessor :sync
	attr_accessor :color_str

	ICON_SHORT = "fa-gears"
	ICON = "fa fa-fw #{ICON_SHORT}"

	DEFAULTS_ICON_SHORT = "fa-check-circle-o"
	DEFAULTS_ICON = "fa fa-fw #{DEFAULTS_ICON_SHORT}"	

	NAV_LOCATION = {
		"Fixed to Top" => 0,
		"Below Header Image - Rounded" => 1,
		"Below Header Image - Square" => 2,
		"Fixed to Bottom" => 3,
		"Left Column" => 4,
		"Right Column" => 5
	}

	NAV_WEIGHT = {
		"Light" => 0,
		"Dark" => 1
	}

	def nav_color_converted
		return nav_color
=begin		
		if self.nav_color.nil?
			return ""
		end

		hex_color = self.nav_color.to_s(16)
		if hex_color.length == 6
			return "##{hex_color}"
		elsif hex_color.length == 8
			op = (hex_color[0,2].hex/255.0).round(2)
			rd = hex_color[2,2].hex
			gr = hex_color[4,2].hex
			bl = hex_color[6,2].hex
			return "rgba(#{rd},#{gr},#{bl},#{op})"
		end
=end		
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
		if self.fluid?
			return "container-fluid"
		else
			return "container"
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
			return ""
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