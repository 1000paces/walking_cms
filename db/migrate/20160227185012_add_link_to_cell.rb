class AddLinkToCell < ActiveRecord::Migration
  def change
  	add_column :cells, :new_window, :boolean, :default => true  
  end
end
