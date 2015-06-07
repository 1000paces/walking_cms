class HelpController < ApplicationController

	def index
	end

	def show
		@help = HelpTopic.find_by_permalink(params[:id])
	end

end