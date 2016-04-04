class Admin::PagesController < Admin::AdminController

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
    @row, @cell = @page.bootstrap

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
    session[:recently_departed] = nil
  	@page = Page.find(params[:id])
    @page.permalink = @page.generate_permalink if @page.permalink.blank?
    @row = @page.rows.first
    @page.update_attributes(page_parameters)
    if @page.errors.any?
      render(:template => "/shared/errors", :layout => false)
    end
    @recently_departed = session[:recently_departed] = @page.id if @page.status == 'DELETE'
  end

  def destroy
  end

  def restore
    if session[:recently_departed].nil?
      @page = @user.home_page
    else
      @page = Page.find(params[:page_id])
      @page.status = 'DRAFT'
      @page.save
    end
    #render(:action => :index, :layout => false)
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
  	params.require(:page).permit(:label, :title, :permalink, :headline, :status, setting_attributes: [:id, :font_id, :font_weight, :fluid, :nav_location, :nav_color, :image, :shape, :text_color, :overlap, :title_background, :title_background_color]).merge(user_id: current_user.id)#, position: current_user.pages.count)
  end
end