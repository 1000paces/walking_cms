class Image < ActiveRecord::Base
	belongs_to :cell
	#mount_uploader :image, ImageUploader

end