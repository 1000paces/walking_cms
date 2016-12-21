class IndexController < ApplicationController
  before_action :get_domain
  before_action :get_owner
  before_action :set_view_path

  def show
  	Rails.logger.warn("\n\nIndexController::show")
  	Rails.logger.warn(":id IS #{params[:id]}")
    Rails.logger.warn("DOMAIN IS #{request.domain}\n\n")
  	if ['1000paces.dev','1000paces.studio'].include?(request.domain)
  		@owner = User.new
  		redirect_to tour_index_path#(params[:id])
  	else
      begin
    		
    		#@owner = @domain.user
        if params[:id].blank?
          @page = @owner.home_page
        else
    		  @page = Page.retrieve(params[:id], @owner.id)
        end
      rescue
        render :file => 'public/404.html', :status => :not_found, :layout => false
      end
  	end  	
  end

  private

  def get_domain
    begin
      @domain = Domain.find_by_name(request.domain) unless ['1000paces.dev','1000paces.studio'].include?(request.domain)
    rescue
      return nil
    end
  end

  def get_owner
    @owner = @domain.user unless @domain.nil?
  end
end
