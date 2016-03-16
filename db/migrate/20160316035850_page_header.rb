class PageHeader < ActiveRecord::Migration
  def change
  	add_column :pages, :image, :string
  	add_column :pages, :headline, :string
  	add_column :pages, :shape, :string
  end
end
