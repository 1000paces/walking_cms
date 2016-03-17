class PageHeader < ActiveRecord::Migration
  def change
  	add_column :pages, :headline, :string
  	add_column :settings, :image, :string
  	add_column :settings, :shape, :string
  end
end
