module ApplicationHelper

	def cdn_js_bootstrap
		"<script src='//maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js'></script>".html_safe
	end

	def cdn_css_bootstrap
		"<link href='//maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css' rel='stylesheet'>".html_safe
	end

	def cdn_css_font_awesome
		"<link href='//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css' rel='stylesheet'>".html_safe
	end

end
