class ImageCrop < ActiveRecord::Migration[5.0]
  def change
  	add_column :cells, :public_id, :string
  	add_column :cells, :image_width, :integer
  	add_column :cells, :image_height, :integer

  	add_column :settings, :public_id, :string
  	add_column :settings, :image_width, :integer
  	add_column :settings, :image_height, :integer
  	add_column :settings, :x1, :integer
  	add_column :settings, :y1, :integer
  	add_column :settings, :w1, :integer
  	add_column :settings, :h1, :integer
  	add_column :settings, :scale, :float
  end
end
