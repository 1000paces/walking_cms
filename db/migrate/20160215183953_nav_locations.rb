class NavLocations < ActiveRecord::Migration
  def change
  	remove_column :pages, :fluid, :boolean
  	remove_column :settings, :top_nav, :boolean
  	add_column :settings, :nav_location, :integer, :default => 0
  	add_column :settings, :nav_color, :string, :default => "rgba(55,58,60,1)"
  	add_column :settings, :page_id, :integer, :default => nil  	
  end
end
