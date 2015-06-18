class RowsController < ApplicationController
  before_action :set_user
  before_filter :require_user

  def create
  	@page = Page.find(params[:row][:page_id])

  	@page.rows.each_with_index do |row, index| 
  		row.position = index+1
  		row.save
  	end

  	@row = @page.rows.create(:position => 0)
  	@cell = @row.cells.create(:body => "I'm the new row: #{@row.id}")
  end


end