class CssSnippet < ActiveRecord::Migration
	def change
		add_column :cells, :css, :text
		add_column :rows, :css, :text
		add_column :pages, :css, :text
		add_column :users, :css, :text
	end
end
