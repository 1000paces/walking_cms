class Admin::CellsController < Admin::AdminController

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
    if params[:adjacent_cell] == "0"
      @page = Page.find(params[:page_id])
      @adjacent_cell = @page.rows.first.cells.first
    else  
      @adjacent_cell = Cell.find params[:adjacent_cell]
    end
    deed = params[:deed]
    direction = params[:direction]

    row = @adjacent_cell.row
    cell_list = row.cell_ids

    if deed == 'add'  #!params[:add].blank?

      pos = cell_list.rindex(@adjacent_cell.id)
      pos+=1 if direction == 'right'

      x,y = @adjacent_cell.division
      @adjacent_cell.width = y
      @cell = Cell.create(:width => x, :position => pos, :row_id => @adjacent_cell.row_id)

      cell_list.insert(pos, @cell.id)
      @adjacent_cell.save
    else
     # Rails.logger.warn("Not in the 'add' section")
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

    #Rails.logger.warn("Update the positions")
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
    @cell.body = "" if @cell.body.nil?
    @body_type = params[:type]
    @row = @cell.row
    @page = @row.page
  end

  def update
    @cell = Cell.find params[:id]
    @row = @cell.row
    @cell.update_attributes(cell_parameters)
    @page = @row.page
  end

  def destroy
    @cell = Cell.find params[:id]
    @row = @cell.row
    @page = @row.page
    @cell.row_id = 0
    @cell.save
    @dead_rows = []
    @page.rows.each do |row|
      if row.cells.empty?
        row.destroy
        @dead_rows << row.id
      end
    end
  end

  def restore
    @page = Page.find(params[:page_id])
    begin
      @row = Row.find(params[:row_id])
    rescue
      p = @page.rows.size
      @row = Row.create(:page_id => @page.id, :position => p)
    end
    @cell = Cell.find(params[:cell_id])
    @row.cells << @cell
  end

  def duplicate
    @source_cell = Cell.find(params[:id])
    @row = @source_cell.row
    @page = @row.page
    cell_list = @row.cells.ids
    @cell = @source_cell.duplicate(@row.id)
    @cell_index = cell_list.rindex(@source_cell.id)+1
    cell_list.insert(@cell_index, @cell.id)
    cell_list.each_with_index do |cell_id, index|
      cell = Cell.find(cell_id)
      unless cell.nil?
        cell.position = index+1
        cell.save
      end
    end
  end

  def sort
    @row = Row.find params[:row_id]
    @page = @row.page
    #Rails.logger.warn("\n\nPARAMS: #{params}\n\n")
    cells = params["wcms-cell"]

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
    params.require(:cell).permit(:width, :offset, :position, :body, :image, :shape, :breakpoint, :headline, :embed_code, :show_headline, :overlay, :variant, :background_color, :css)
  end

end