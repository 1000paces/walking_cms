class Admin::SitesController < ApplicationController
	before_action :set_user, only: [:show]
  before_filter :require_user, only: [:show]

  def show
    if params[:id].nil?
      @page = @user.home_page
    elsif params[:id].to_i.to_s == params[:id] #### find via Page#id
      @page = Page.find params[:id]
    else
      @page = Page.find_by_permalink params[:id]
    end
    if @page.rows.empty?
      @row = @page.rows.create 
      @cell = @row.cells.create(:body => "")
    end
    session[:current_page] = @page.id
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(session[:user_credentials_id])
    end
end