class AddPageElements < ActiveRecord::Migration
  def change
  	add_column :settings, :text_color, :string, :default => "rgba(0,0,0,1)"
  	add_column :settings, :overlap, :boolean, :default => false
  end
end
