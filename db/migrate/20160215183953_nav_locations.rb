class NavLocations < ActiveRecord::Migration
  def change
  	remove_column :pages, :fluid, :boolean
  	remove_column :settings, :top_nav, :boolean
  	add_column :settings, :nav_location, :integer, :default => 0
  	add_column :settings, :nav_color, :string, :default => "#666666"
  	add_column :settings, :nav_weight, :integer, :default => 0
  	add_column :settings, :page_id, :integer, :default => nil  	
  end
end
