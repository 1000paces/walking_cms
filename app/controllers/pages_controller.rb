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
		sorted_list = params[:item]

		if params[:socket] == 'linked'
			sorted_list.each_with_index do |member, index|
				child = Page.find(member[0].to_i)
				parent = member[1]=="null" ? nil : Page.find(member[1].to_i)
				if parent.nil?
					child.position = index
					child.parent_id = nil
					child.save
				else
					parent.children << child
					child.position = index
					child.save
				end
			end
		else
			sorted_list.each_with_index do |member, index|
				child = Page.find(member[0].to_i)
				child.position = nil
				child.parent_id = nil
				child.save
			end
		end
  end

  private

  def page_parameters
  	params.require(:page).permit(:label, :title, :permalink, :status, :fluid).merge(user_id: current_user.id, position: current_user.pages.count)
  end
end