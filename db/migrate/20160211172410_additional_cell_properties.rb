class AdditionalCellProperties < ActiveRecord::Migration
  def change
  	add_column :cells, :breakpoint, :string, :default => "md"
  	add_column :cells, :border, :boolean, :default => false
  	add_column :cells, :headline, :string, :default => ""
  	add_column :cells, :show_headline, :boolean, :default => false
  	add_column :cells, :embed_code, :text
  end
end
