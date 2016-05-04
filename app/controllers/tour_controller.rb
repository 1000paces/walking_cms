class TourController < ApplicationController

  def index
  	@user = User.new
  	Rails.logger.warn("\n\nTourController::show")
  	Rails.logger.warn("domain IS #{request.domain}\n\n")
  end

  def more
  	@user = User.new
  end
end
