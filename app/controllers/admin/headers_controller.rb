class Admin::HeadersController < Admin::AdminController

  def show
  	@page = Page.find params[:id]
  end

  def new

  end

  def create

  end

  def edit
  	@page = Page.find params[:id]
    @form_type = params[:type]
  end

  def update
    @page = Page.find(params[:id])
    stg = @page.setting
    #img = MiniMagick::Image.open(@page.setting.image.path)
    if params[:page][:setting_attributes][:scale] == 'nil'
      stg.uncrop
    else  
      crop_x, crop_y, crop_w, crop_h, placed_w, placed_h = params[:page][:setting_attributes].values_at(:crop_x,:crop_y,:crop_w,:crop_h,:placed_w,:placed_h)

      stg.scale = placed_w.to_i / stg.image_width.to_f
      if stg.scale > 0
        stg.x1 = (crop_x.to_i / stg.scale).to_i
        stg.y1 = (crop_y.to_i / stg.scale).to_i
        stg.w1 = (crop_w.to_i / stg.scale).to_i
        stg.h1 = (crop_h.to_i / stg.scale).to_i
      end
    end
    @page.save
    
    redirect_to  admin_site_path(@page.permalink_or_id)
  end

  def destroy

  end
end