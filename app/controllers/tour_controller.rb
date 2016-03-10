class TourController < ApplicationController
  def index
  	@user = User.new
  	Rails.logger.warn("\n\nTourController::show")
  	Rails.logger.warn("domain IS #{request.domain}\n\n")
  	#if request.domain != "stonewall.dev"
  	#	redirect_to public_path(params[:id])
  	#end
  end
end
