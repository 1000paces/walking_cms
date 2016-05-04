module ApplicationHelper

	def cdn_css_motion_ui
		"<link rel='stylesheet' href='//cdnjs.cloudflare.com/ajax/libs/motion-ui/1.1.1/motion-ui.min.css' />".html_safe
	end

	def cdn_js_framework(v=nil)
		if v == 'f6'
			"<script src='//cdnjs.cloudflare.com/ajax/libs/foundation/6.2.0/foundation.min.js'></script>".html_safe
		else
			"<script src='//maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.2/js/bootstrap.min.js'></script>".html_safe
		end
	end

	def cdn_css_framework(v=nil)
		if v == 'f6'
			"<link rel='stylesheet' href='//cdnjs.cloudflare.com/ajax/libs/foundation/6.2.0/foundation.min.css'>".html_safe
		else
			"<link rel='stylesheet' href='//maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.2/css/bootstrap.min.css'>".html_safe
		end
	end

	def wcms_css(v='b3')		
		stylesheet_link_tag("#{v}/sites", "#{v}/custom")
	end

	def wsmc_js(v=nil)
		case v
		when 'b3'
		else

		end
	end

	def cdn_css_font_awesome
		"<link href='//maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css' rel='stylesheet'>".html_safe
	end

	def cdn_jquery_flip
		"<script src='https://cdn.rawgit.com/nnattawat/flip/v1.0.19/dist/jquery.flip.min.js'></script>".html_safe
	end

	def cms_name
		"1000paces.studio"
	end

	def cms_icon(s=24)
		#"<i class='fa fa-pencil fa-fw'></i>".html_safe
		image_tag('1kp_studio_1000x113.png', :size => "#{s}", :style => "display: inline-block;")
	end

	def cms_logo
		image_tag('1kp_studio.png', :class => "wcms-header-img")
	end

	def cms_brand
		image_tag('1kp_studio_1000x113.png', :width => "145", :style => "display: inline-block;")
	end
end


