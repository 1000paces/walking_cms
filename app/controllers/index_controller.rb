class IndexController < ApplicationController
  def show
  	Rails.logger.warn("\n\nIndexController::show")
  	Rails.logger.warn(":id IS #{params[:id]}\n\n")
  	if request.domain == "stonewall.dev"
  		@user = User.new
  		redirect_to tour_index_path(params[:id])
  	else
      begin
    		@domain = Domain.find_by_name(request.domain)
    		@user = @domain.user
        if params[:id].blank?
          @page = @user.home_page
        else
    		  @page = Page.retrieve(params[:id], @user.id)
        end
      rescue
        render :file => 'public/404.html', :status => :not_found, :layout => false
      end
  	end  	
  end
end
