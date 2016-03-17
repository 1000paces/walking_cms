class PageTitleBackground < ActiveRecord::Migration
  def change
  	add_column :settings, :title_background, :integer, :default => 1
  	add_column :settings, :title_background_color, :string, :default => "rgba(255,255,255,0.5)"
  end
end
