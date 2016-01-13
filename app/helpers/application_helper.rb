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

end


