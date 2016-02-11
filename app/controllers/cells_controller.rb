class CellsController < ApplicationController
  before_action :set_user
  before_filter :require_user

  def index

  end

  def show
    @cell = Cell.find params[:id]
    @row = @cell.row
    @page = @row.page
  end

  def new

  end

  def create
    @adjacent_cell = Cell.find params[:adjacent_cell]
    deed = params[:deed]
    direction = params[:direction]

    row = @adjacent_cell.row
    cell_list = row.cell_ids

    if deed == 'add'  #!params[:add].blank?
      #add = params[:add]
      pos = direction == "left" ? @adjacent_cell.position-1 : @adjacent_cell.position
      x,y = @adjacent_cell.division
      @adjacent_cell.width = y
      @cell = Cell.create(:width => x, :position => pos, :row_id => @adjacent_cell.row_id, :body => "I'm the new cell")
      cell_list.insert(pos, @cell.id)
      @adjacent_cell.save
    else
      #merge = params[:merge]
      if direction == 'left'
        dcell_index = cell_list.index(@adjacent_cell.id)-1
        dcell = Cell.find cell_list[dcell_index]
        @adjacent_cell.body = "#{dcell.body} <!--MERGE POINT--> #{@adjacent_cell.body}"
      else
        dcell_index = cell_list.index(@adjacent_cell.id)+1
        dcell = Cell.find cell_list[dcell_index]
        @adjacent_cell.body = "#{@adjacent_cell.body} <!--MERGE POINT--> #{dcell.body}"
      end
      @adjacent_cell.width = dcell.width + @adjacent_cell.width
      @adjacent_cell.save
      cell_list.delete(dcell.id)
      row.cells.find(dcell.id).destroy
    end

    cell_list.each_with_index do |cell_id, index|
      cell = Cell.find(cell_id)
      unless cell.nil?
        cell.position = index+1
        cell.save
      end
    end

    @row = Row.find row.id
  end

  def edit
    @cell = Cell.find params[:id]
    @body_type = params[:type]
    @row = @cell.row
    @page = @row.page

    #if @body_type == 'image'
      

    #elsif @body_type == 'code'

    #end
  end

  def update
    @cell = Cell.find params[:id]
    @row = @cell.row
    @cell.update_attributes(cell_parameters)
    Rails.logger.warn("\n\nWIDTH IS NOW #{@cell.width}\n\n")
    @page = @row.page
  end

  def destroy

  end

  def sort
    @row = Row.find params[:row_id]
    @page = @row.page
    #Rails.logger.warn("\n\nPARAMS: #{params}\n\n")
    cells = params["wcms-work-cell"]

    case request.method
    when 'GET'
    when 'POST'
      cells.each_with_index do |cell_id, index|
        c = Cell.find cell_id
        c.position = index
        c.row_id = @row.id
        c.save
      end
      render :nothing => true
    end
  end

  private

  def cell_parameters
    params.require(:cell).permit(:width, :offset, :position, :body, :image, :shape, :breakpoint, :border, :headline, :embed_code, :show_headline)
  end

end