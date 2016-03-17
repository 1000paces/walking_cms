class Admin::HeadersController < ApplicationController
  before_action :set_user
  before_filter :require_user

  def show
  	@page = Page.find params[:id]
  end

  def new

  end

  def create

  end

  def edit
  	@page = Page.find params[:id]
  end

  def update
    @page = Page.find(params[:id])
    img = MiniMagick::Image.open(@page.image.path)
    crop_x, crop_y, crop_w, crop_h, placed_w, placed_h = params[:page].values_at(:crop_x,:crop_y,:crop_w,:crop_h,:placed_w,:placed_h)
    #img = @page.image.resize_with_crop(img, placed_w.to_i, placed_h.to_i, {:w_offset => crop_x.to_i, :h_offset => crop_y.to_i})
    Rails.logger.warn("\n\n#{img}\n\n")

    ###get scaled ratio
    scaled_by = placed_w.to_i / img[:width].to_f
    Rails.logger.warn("\n\nScale is #{scaled_by}")
    scrop_x = (crop_x.to_i / scaled_by).to_i
    scrop_y = (crop_y.to_i / scaled_by).to_i
    scrop_w = (crop_w.to_i / scaled_by).to_i
    scrop_h = (crop_h.to_i / scaled_by).to_i

    #scaled_crop = "#{scrop_x}x#{scrop_y}+#{scrop_w}+#{scrop_h}"
    scaled_crop = "#{scrop_w}x#{scrop_h}+#{scrop_x}+#{scrop_y}"
    #crop_params = "#{crop_x}x#{crop_y}+#{crop_w}+#{crop_h}"

    Rails.logger.warn("\n\nARGS: #{scaled_crop}")
    #img.resize "#{crop_w}x#{crop_y}"
    img.crop "#{scaled_crop}!"
    img.write(@page.image.path)
    img
    redirect_to  admin_site_path(@page.permalink_or_id)
  end

  def destroy

  end
end