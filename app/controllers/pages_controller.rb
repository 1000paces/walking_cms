class PagesController < ApplicationController
  before_action :set_user#, except: [:show]
  before_filter :require_user#, only: [:show]

  def index
    @page = @user.home_page
  end

  def show
    @page = Page.find(params[:id])
    session[:current_page] = @page.id
    @row = @page.rows.build 
    #if @page.rows.empty?
    #  @row = @page.rows.create
      #@cell = @row.cells.build(:body => "Type something here")
    #end
  end

  def new
  	@page = Page.new(:label => "New Page")
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
  	params.require(:page).permit(:label, :title, :permalink, :status, :fluid).merge(user_id: current_user.id)#, position: current_user.pages.count)
  end
end