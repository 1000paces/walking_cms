class Admin::SitesController < Admin::AdminController

  def show
    if params[:id].nil?
      @page = @user.home_page
    elsif params[:id].to_i.to_s == params[:id] #### find via Page#id
      @page = @user.pages.find params[:id]
    else
      @page = @user.pages.find_by_permalink(params[:id])
    end
    Rails.logger.warn("\n\nPAGE: #{@page.id}")
    @page.save if @page.new_record?
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