module ApplicationHelper

	def cdn_js_bootstrap
		"<script src='https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.2/js/bootstrap.min.js'></script>".html_safe
	end

	def cdn_css_bootstrap
		"<link rel='stylesheet' href='//maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.2/css/bootstrap.min.css'>".html_safe
	end

	def cdn_css_font_awesome
		"<link href='//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css' rel='stylesheet'>".html_safe
	end

	def cdn_jquery_flip
		"<script src='https://cdn.rawgit.com/nnattawat/flip/v1.0.19/dist/jquery.flip.min.js'></script>".html_safe
	end

	def cms_name
		"1000paces.studio"
	end

	def cms_icon(s=24)
		#"<i class='fa fa-pencil fa-fw'></i>".html_safe
		image_tag('feet_walking_white.png', :size => "#{s}", :style => "display: inline-block;")
	end

	def nav_class(setting)
		case setting.nav_location
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

	def nav_color_horizontal(setting)
		case setting.nav_color
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

	def nav_color_vertical(setting)
		case setting.nav_color
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


