class SitesController < ApplicationController
  before_action :set_user, only: [:show]
  before_filter :require_user, only: [:show]

  # GET /users/1
  # GET /users/1.json
  def show
    if params[:id].nil?
      @page = @user.home_page
    else
      @page = Page.find params[:id]
    end
    if @page.rows.empty?
      @row = @page.rows.create 
      @cell = @row.cells.create(:body => "")
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(session[:user_credentials_id])
    end
end
