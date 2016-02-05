class AddImages < ActiveRecord::Migration
  def change
  	add_column :cells, :image, :string
  end
end
