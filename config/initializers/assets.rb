# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w( 
	stonewall_press.png 
	stonewall_press_brand.png 
	s_logo.png 
	feet_walking_black.png 
	feet_walking_white.png 
	f6/sites.css
	b4/sites.css
	f6/custom.css
	b4/custom.css	
	1kp_studio_1000x113.png
)

