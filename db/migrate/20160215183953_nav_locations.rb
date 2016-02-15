class NavLocations < ActiveRecord::Migration
  def change
  	remove_column :settings, :top_nav, :boolean
  	add_column :settings, :nav_location, :integer, :default => 0
  	add_column :settings, :nav_color, :integer, :default => 0
  end
end
