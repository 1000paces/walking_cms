class PagesController < ApplicationController
  before_action :set_user, except: [:show]
  before_filter :require_user, only: [:show]

  def index
  end

  def show
  end

  def new
  	@page = Page.new
  end

  def create
  	@page = Page.create(page_parameters)
  end

  def edit
  	@page = Page.find(params[:id])
  end

  def update
  	@page = Page.find(params[:id])
  	@page.update_attributes(page_parameters)
  	Rails.logger.warn("Page Label is #{@page.label}")
  end

  def destroy
  end

  def sort
  	sorted_list = params[:page_li].keys
  	Rails.logger.warn("KEYS: #{sorted_list}")
		sorted_list.each_with_index do |p, index|
			page = Page.find(p)
			page.position = index
			page.save
		end

  	render :nothing => true
  end

  private

  def page_parameters
  	params.require(:page).permit(:label, :title, :permalink, :status, :fluid).merge(user_id: current_user.id, position: current_user.pages.count)
  end
end