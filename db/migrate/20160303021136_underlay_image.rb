class UnderlayImage < ActiveRecord::Migration
  def change
  	remove_column :cells, :border, :boolean, :default => false
  	add_column :cells, :overlay, :boolean, :default => false  
  	add_column :cells, :variant, :integer, :default => 0
  	add_column :cells, :background_color, :string, :default => "rgba(255,255,255,1)"
  end
end
