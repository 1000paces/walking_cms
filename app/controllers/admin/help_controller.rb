class Admin::HelpController < Admin::AdminController


	def index
	end

	def show
		@help = HelpTopic.find_by_permalink(params[:id])
	end

end