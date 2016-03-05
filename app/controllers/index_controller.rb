class IndexController < ApplicationController
  def show
  	@user = User.new
  	Rails.logger.warn("\n\nID IS #{params[:id]}\n\n")
  end
end
