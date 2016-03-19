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
    img = MiniMagick::Image.open(@page.setting.image.path)
    crop_x, crop_y, crop_w, crop_h, placed_w, placed_h = params[:page][:setting_attributes].values_at(:crop_x,:crop_y,:crop_w,:crop_h,:placed_w,:placed_h)
    #img = @page.image.resize_with_crop(img, placed_w.to_i, placed_h.to_i, {:w_offset => crop_x.to_i, :h_offset => crop_y.to_i})
    Rails.logger.warn("\n\n#{img}\n\n")

    ###get scaled ratio
    scaled_by = placed_w.to_i / img[:width].to_f
    Rails.logger.warn("\n\nScale is #{scaled_by}")
    if scaled_by > 0
      crop_x = (crop_x.to_i / scaled_by).to_i
      crop_y = (crop_y.to_i / scaled_by).to_i
      crop_w = (crop_w.to_i / scaled_by).to_i
      crop_h = (crop_h.to_i / scaled_by).to_i
    end
    #scaled_crop = "#{scrop_x}x#{scrop_y}+#{scrop_w}+#{scrop_h}"
    scaled_crop = "#{crop_w}x#{crop_h}+#{crop_x}+#{crop_y}"
    #crop_params = "#{crop_x}x#{crop_y}+#{crop_w}+#{crop_h}"

    Rails.logger.warn("\n\nARGS: #{scaled_crop}")
    #img.resize "#{crop_w}x#{crop_y}"
    img.crop "#{scaled_crop}!"
    img.write(@page.setting.image.path)
    img
    redirect_to  admin_site_path(@page.permalink_or_id)
  end

  def destroy

  end
end