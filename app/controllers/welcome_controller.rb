class WelcomeController < ApplicationController
  def index
  	@user = User.new
  	if request.domain != "stonewall.dev"
  		redirect_to public_path(params[:id])
  	end
  end
end
