class RowsController < ApplicationController
  before_action :set_user
  before_filter :require_user

  def index
    
  end

  def create
  	@page = Page.find(params[:row][:page_id])

  	@page.rows.each_with_index do |row, index| 
  		row.position = index+1
  		row.save
  	end

  	@row = @page.rows.create(:position => 0)
  	@cell = @row.cells.create(:body => "I'm the new row: #{@row.id}")
  end



  def edit

  end

  def update

  end

  def sort
    @page = Page.find params[:page_id]
    rows = params["wcms-toolbox"]

    case request.method
    when 'GET'
    when 'POST'
      rows.each_with_index do |row_id, index|
        r = Row.find(row_id)
        r.position = index
        r.save
      end
      render :nothing => true
    end

  end


end