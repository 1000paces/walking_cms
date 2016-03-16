class Admin::PagesController < ApplicationController
  before_action :set_user#, except: [:show]
  before_filter :require_user#, only: [:show]

  def index
    @page = @user.home_page
  end

  def show
    @page = Page.find(params[:id])
    session[:current_page] = @page.id
    @row = @page.rows.build 
  end

  def new
  	@page = @user.pages.build(:label => "New Page")
  end

  def create
  	@page = Page.create(page_parameters)
  end

  def duplicate
    old_page = Page.find(params[:id])
    @page = old_page.duplicate
  end

  def edit
  	@page = Page.find(params[:id])
    @row = @page.rows.first
  end

  def update
  	@page = Page.find(params[:id])
    @row = @page.rows.first
    @page.update_attributes(page_parameters)
    if @page.errors.any?
      render(:template => "/shared/errors", :layout => false)
    end
  end

  def destroy
  end

  def sort
		sorted_list = params[:item]

    @page = session[:current_page].blank? ? @user.home_page : Page.find(session[:current_page])
    
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
  	params.require(:page).permit(:label, :title, :permalink, :headline, :image, :shape, :text_color, :status, setting_attributes: [:id, :font_id, :font_weight, :fluid, :nav_location, :nav_color, :nav_weight]).merge(user_id: current_user.id)#, position: current_user.pages.count)
  end
end