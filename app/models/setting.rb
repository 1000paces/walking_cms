class Setting < ActiveRecord::Base
	belongs_to :user
	belongs_to :page
	belongs_to :font

	attr_accessor :sync
	attr_accessor :color_str

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
			return "style='background-color: #{self.nav_color_converted};'".html_safe
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
		if self.nav_weight == 0 #### light
			return "#{nav_style}-light bg-faded"
		else #### dark
			return "#{nav_style}-dark bg-inverse"
		end
	end

	def nav_class
		case self.nav_location
		when 1 ##### below header image rounded
			return ""
		when 2 #### below header image square
			return "navbar-full"
		when 3 #### fixed to bottom
			return "navbar-fixed-bottom"
		when 4
			return ""
		when 5 #### left or right nav
			return ""
		else #### fixed to top
			return "navbar-fixed-top"
		end
	end

	def nav_color_horizontal
		case self.nav_color
		when 0
			return "navbar-light bg-faded"
		when 1
			return "navbar-dark bg-inverse"
		when 2
			return "navbar-dark bg-primary"
		when 3
			return "navbar-light bg-secondary"
		end
	end

	def nav_color_vertical
		case self.nav_color
		when 0
			return "nav-pills-light bg-faded"
		when 1
			return "nav-pills-dark bg-inverse"
		when 2
			return "nav-pills-dark bg-primary"
		when 3
			return "nav-pills-light bg-secondary"
		end
	end
end