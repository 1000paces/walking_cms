class AddPageElements < ActiveRecord::Migration
  def change
  	add_column :pages, :text_color, :string, :default => "rgba(0,0,0,1)"
  	add_column :pages, :overlap, :boolean, :default => false
  end
end
