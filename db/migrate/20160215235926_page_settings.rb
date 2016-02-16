class PageSettings < ActiveRecord::Migration
  def change
  	remove_column :pages, :fluid, :boolean
  	add_column :settings, :page_id, :integer, :default => nil
  end
end
