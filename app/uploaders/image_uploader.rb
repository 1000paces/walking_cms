# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  #include CarrierWave::MiniMagick
  include Cloudinary::CarrierWave


  GRAVITY_TYPES = [ :north_west, :north, :north_east, :east, :south_east, :south, :south_west, :west, :center ]


  # Choose what kind of storage to use for this uploader:
  #if Rails.env.development? || Rails.env.test?
  #  storage :file
  #else
  #  storage :fog
  #end
  version :cropped do
    process :crop_and_scale
  end

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  #def store_dir
  #  "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  #end

  # Provide a default URL as a default if there hasn't been a file uploaded:
   def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
    'default_image.png'
   end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  def scale(width, height)
    resize_to_fit(width, height)
  end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :resize_to_fit => [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  private

  def crop_and_scale
    params = []

    params << {
      width: model.w1.to_i,
      height: model.h1.to_i,
      x: model.x1.to_i,
      y: model.y1.to_i,
      crop: "crop"
    }

    {:transformation => params}    
  end


end
