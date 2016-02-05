class ImagesController < ApplicationController

	def index
		@images = Image.all
	end

	def new 
		@image = Image.new
	end

	def create
		@image = Image.new(image_params)

		if @image.save
			redirect_to images_path, notice: "Image #{@image.name} has been uploaded"
		else
			render "new"
		end
	end

	def destroy
		@image = Image.find(params[:id])
		@image.destroy
		redirect_to images_path, notice: "Image #{@image.name} has been removed"
	end

	private

	def image_params
		params.require!(:image).permit(:name, :attachment)
	end

end