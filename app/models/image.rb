class Image < ActiveRecord::Base
	belongs_to :cell
	belongs_to :setting
	#mount_uploader :image, ImageUploader

end